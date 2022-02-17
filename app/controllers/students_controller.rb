class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
        render json: Student.all
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def not_found
        render json: {errors: "Not Found"}, status: :not_found
    end

end
