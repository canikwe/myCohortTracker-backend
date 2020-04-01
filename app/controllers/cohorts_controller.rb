class CohortsController < ApplicationController
  before_action :get_cohort, only: [:update]

  def index
    render json: ApplicationSerializer.new(Cohort.all).to_json, status: :ok
  end

  def show
    cohort = Cohort.find_by(batch_id: params[:id])

    render json: {cohort: ApplicationSerializer.new(cohort).as_json, students: ApplicationSerializer.new(cohort.students).as_json, groups: GroupSerializer.new(cohort.groups).as_json}, status: :ok
  end

  def create
    cohort = Cohort.create(cohort_params)
    if cohort.valid?
      cohort.students.create(cohort_student_params[:students])

      render json: {cohort: ApplicationSerializer.new(cohort).as_json, students: ApplicationSerializer.new(cohort.students).as_json, compliment: compliment_user}, status: :ok
    else
      render json: {message: cohort.errors.full_messages.as_json}, status: :not_acceptable
    end
  end

  def update
    
    if @cohort.update(cohort_params)
      updated_student_ids = cohort_student_params[:students].map do |s_params|
        
        if s_params[:id]
          student = Student.find(s_params[:id])
          student.update(s_params)
          s_params[:id]
        else
          student = @cohort.students.create(s_params)
          student.id
        end
      end
      
      # delete removed students from the db
      removed_student_ids = @cohort.student_ids - updated_student_ids

      removed_student_ids.each do |s|
        Student.destroy(s)
      end

      @cohort.student_ids = updated_student_ids
      
      render json: {cohort: ApplicationSerializer.new(@cohort).as_json, students: ApplicationSerializer.new(@cohort.students).as_json, groups: GroupSerializer.new(@cohort.groups).as_json, compliment: compliment_user}, status: :ok
    else
      render json: {message: @cohort.errors.full_messages.as_json}, status: :not_acceptable
    end
  end

  def csv_upload
    cohort_params = JSON.parse(params[:cohort])
    cohort = Cohort.create(cohort_params)

    if cohort.valid?
      csv = params["csv"].tempfile
      students = []
      CSV.foreach(csv, headers: true) do |r|
        row = r.to_h
        students << {first_name: row['first_name'], last_name: row['last_name']}
      end
      cohort.students.create(students)
      render json: {cohort: ApplicationSerializer.new(cohort).as_json, students: ApplicationSerializer.new(cohort.students).as_json}, status: :ok
    else
      render json: {message: cohort.errors.full_messages.as_json}, status: :not_acceptable
    end
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

end
