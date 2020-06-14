class StudentsController < ApplicationController
  before_action :get_student

  def index
    render json: ApplicationSerializer.new(Student.all).as_json, status: :ok
  end

  def update
    if @student.update(student_params)
      render json: ApplicationSerializer.new(@student).as_json, status: :ok
    else
      render json: {message: @student.errors.full_messages.as_json}, status: :not_acceptable
    end
  end

  private

  def get_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:id, :first_name, :last_name, :cohort_id)
  end

end
