class StudentsController < ApplicationController

  def index
    render json: ApplicationSerializer.new(Student.all).as_json, status: :ok
  end

end
