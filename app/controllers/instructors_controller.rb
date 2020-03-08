class InstructorsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    instructor = Instructor.create(instructor_params)
    if instructor.valid?
      token = encode_token({ instructor_id: instructor.id })
      render json: {instructor: instructor.as_json(serializer_options), jwt: token}, status: :created
    else
      render json: {error: 'failed to create instructor'}, status: :not_acceptable
    end
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :password)
  end

  def serializer_options
    {except: [:created_at, :updated_at, :password_digest]}
  end
end
