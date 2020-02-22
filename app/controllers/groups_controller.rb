class GroupsController < ApplicationController
  before_action :get_group, only: [:update, :delete]

  def index
    render json: Group.all.to_json(group_serializer)
  end

  def update
    @group.update(group_params)
    
    render json: @group.to_json(group_serializer)
  end

  def create
    activity = Activity.find_or_create_by(activity_params)
    group = Group.create!(activity_id: activity.id)
    group.update(group_params)

    render json: group.to_json(group_serializer)
  end

  private

  def get_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:avoid, :notes, :id, :activity_id, :student_ids => [])
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
