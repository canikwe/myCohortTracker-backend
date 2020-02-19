class ActivitiesController < ApplicationController

  def index
    render json: Activity.all.to_json(activity_serializer)
  end

  private

  def activity_serializer
    {
      except: [:created_at, :updated_at]
    }
  end
end
