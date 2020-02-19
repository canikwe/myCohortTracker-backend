class GroupsController < ApplicationController

  def index
    render json: Group.all.to_json(group_serializer)
  end

  def create
    # byebug
    activity = Activity.find_or_create_by(activity_params)
    group = Group.create!(activity_id: activity.id)
    group_params[:student_ids].each do |s|
      StudentGroup.create!(student_id: s, group_id: group.id)
    end

    render json: group.to_json(group_serializer)
  end

  private

  def group_params
    params.require(:group).permit(:student_ids => [])
  end

  def activity_params
    params.require(:activity).permit(:id, :name, :mod, :category)
  end

  def group_serializer
    {
      except: [:created_at, :updated_at, :activity_id],
      include: [{:activity => {except: [:created_at, :updated_at]}}],
      methods: [:student_ids]
    }
  end
end
