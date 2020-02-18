class CohortsController < ApplicationController

  def index
    @cohorts = Cohorts.all
  end

  def show
    render json: get_cohort
  end

  private

  def get_cohort
    Cohort.find(params[:id])
  end
end
