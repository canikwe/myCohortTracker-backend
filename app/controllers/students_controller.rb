class StudentsController < ApplicationController

  def index
    render json: Student.all.to_json(serializer_options)
  end

  private

  def serializer_options
    {include: {:pairs => {except: [:created_at, :updated_at]}}, except: [:created_at, :updated_at]}
  end
end
