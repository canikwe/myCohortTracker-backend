class ActivitiesController < ApplicationController

  def index
    render json: ApplicationSerializer.new(Activity.all).to_json, status: :ok
  end

  def create
    activity = Activity.find_or_create_by(activity_params)
    render json: ApplicationSerializer.new(activity).to_json, status: :created
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :mod, :category)
  end

end
