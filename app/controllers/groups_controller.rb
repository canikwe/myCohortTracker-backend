class GroupsController < ApplicationController

  def index
    render json: Group.all.to_json(group_serializer)
  end

  def create
    # byebug
    activity = Activity.find_or_create_by(activity_params)
    group = Group.create!(activity_id: activity.id)
    group.update(group_params)
    student_group_params[:student_ids].each do |id|
      StudentGroup.find_or_create_by(student_id: id, group_id: group.id)
    end

    render json: group.to_json(group_serializer)
  end

  private

  def group_params
    params.require(:group).permit(:avoid, :notes, :id, :activity_id)
  end

  def activity_params
    params.require(:activity).permit(:id, :name, :mod, :category)
  end

  def student_group_params
    params.require(:student_group).permit(:student_ids => [])
  end

  def group_serializer
    {
      except: [:created_at, :updated_at, :activity_id],
      include: [{:activity => {except: [:created_at, :updated_at]}}],
      methods: [:student_ids]
    }
  end
end
