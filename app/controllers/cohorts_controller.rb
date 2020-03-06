
class CohortsController < ApplicationController

  def index
    # hard coded the first and only cohort for now
    render json: Cohort.all.to_json(serializer_options)
  end

  def show
    cohort = Cohort.find_by(batch_id: params[:id])

    render json: {cohort: cohort.as_json(serializer_options), students: cohort.students.as_json(serializer_options), groups: cohort.groups.as_json(group_serializer)}
  end

  def create
  
    byebug


    # IO.copy_stream(download, 'test.csv')

    # CSV.new(file).each do |row| 
    #   puts row
    # end

    cohort = Cohort.create(cohort_params)
    cohort.students.create(cohort_student_params[:students])

    render json: {cohort: cohort.as_json(serializer_options), students: cohort.students.as_json(serializer_options), groups: cohort.groups.as_json(group_serializer)}
  end

  private

  def cohort_params
    params.require(:cohort).permit(:batch, :name, :batch_id)
  end

  def cohort_student_params
  params.require(:cohort).permit(:students => [:first_name, :last_name])
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
