class StudentsController < ApplicationController

  def index
    render json: Student.all.as_json(serializer_options)
  end

  private

  def serializer_options
    { except: [:created_at, :updated_at] }
  end
end
