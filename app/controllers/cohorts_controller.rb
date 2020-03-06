class CohortsController < ApplicationController

  def index
    # hard coded the first and only cohort for now
    render json: Cohort.all.to_json(serializer_options)
  end

  def show
    render json: get_cohort
  end

  private

  def get_cohort
    Cohort.find(params[:id])
  end

  def serializer_options
    { :except => [:created_at, :updated_at] }

  end
end
