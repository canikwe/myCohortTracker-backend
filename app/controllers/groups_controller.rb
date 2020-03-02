class GroupsController < ApplicationController
  before_action :get_group, only: [:update, :destroy]

  def index
    render json: Group.all.to_json(group_serializer)
  end

  def update
    @group.update(group_params)
    
    render json: @group.to_json(group_serializer)
  end

  def create
    group = Group.create!(group_params)

    render json: group.to_json(group_serializer)
  end

  def destroy
    group = @group
    @group.destroy

    render json: group.to_json(group_serializer)
  end

  private

  def get_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:avoid, :notes, :id, :activity_id, :activity_date, :student_ids => [])
  end

  def group_serializer
    {
      except: [:created_at, :updated_at, :activity_id],
      include: [{:activity => {except: [:created_at, :updated_at]}}],
      methods: [:student_ids]
    }
  end
end
