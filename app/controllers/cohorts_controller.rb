
class CohortsController < ApplicationController
  before_action :get_cohort, only: [:update]

  def index
    render json: Cohort.all.to_json(serializer_options), status: :ok
  end

  def show
    cohort = Cohort.find_by(batch_id: params[:id])

    render json: {cohort: cohort.as_json(serializer_options), students: cohort.students.as_json(serializer_options), groups: cohort.groups.as_json(group_serializer)}, status: :ok
  end

  def create
    cohort = Cohort.create(cohort_params)
    cohort.students.create(cohort_student_params[:students])

    render json: {cohort: cohort.as_json(serializer_options), students: cohort.students.as_json(serializer_options)}, status: :ok
  end

  def update
    @cohort.update(cohort_params)
    
    student_ids = cohort_student_params[:students].map do |s_params|
      
      if s_params[:id]
        student = Student.find(s_params[:id])
        student.update(s_params)
        s_params[:id]
      else
        student = @cohort.students.create(s_params)
        student.id
      end
    end

    @cohort.student_ids = student_ids
    
    render json: {cohort: @cohort.as_json(serializer_options), students: @cohort.students.as_json(serializer_options), groups: @cohort.groups.as_json(group_serializer)}, status: :ok
  end

  def csv_upload
    cohort_params = JSON.parse(params[:cohort])
    cohort = Cohort.create(cohort_params)
    csv = params["csv"].tempfile
    students = []
    CSV.foreach(csv, headers: true) do |r|
      row = r.to_h
      students << {first_name: row['first_name'], last_name: row['last_name']}
    end
    cohort.students.create(students)
    render json: {cohort: cohort.as_json(serializer_options), students: cohort.students.as_json(serializer_options)}, status: :ok
  end

  private

  def cohort_params
    params.require(:cohort).permit(:batch, :name, :batch_id)
  end

  def cohort_student_params
    params.require(:cohort).permit(:students => [:first_name, :last_name, :cohort_id, :avatar, :id])
  end

  def get_cohort
    @cohort = Cohort.find(params[:id])
  end

  def serializer_options
    { :except => [:created_at, :updated_at] }
  end

    def group_serializer
    {
      except: [:created_at, :updated_at, :activity_id],
      include: [{:activity => {except: [:created_at, :updated_at]}}],
      methods: [:student_ids]
    }
  end
end
