class ActivitiesController < ApplicationController

  def index
    render json: Activity.all.to_json(activity_serializer)
  end

  def create
    activity = Activity.find_or_create_by(activity_params)
    render json: activity.to_json(activity_serializer)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :mod, :category)
  end

  def activity_serializer
    {
      except: [:created_at, :updated_at]
    }
  end
end
