class StudentsController < ApplicationController

  def index
    render json: Student.all.as_json(serializer_options)
  end

  private

  def serializer_options
    {
      except: [:created_at, :updated_at],
      include: {
        :groups => {
          include: :students,
          :methods => [:activity_name, :student_ids]
        }
      }
    }
  end
end
