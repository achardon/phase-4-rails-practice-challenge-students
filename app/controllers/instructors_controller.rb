class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        render json: Instructor.all
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found
        render json: {error: "Not Found"}, status: :not_found
    end


end
