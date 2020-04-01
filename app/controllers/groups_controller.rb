class GroupsController < ApplicationController
  before_action :get_group, only: [:update, :destroy]

  def index
    render json: GroupSerializer.new(Group.all).to_json, status: :ok
  end

  def update
    @group.update(group_params)
    
    render json: GroupSerializer.new(@group).to_json, status: :ok
  end

  def create

    group = Group.create!(group_params)

    render json: GroupSerializer.new(group).to_json, status: :created
  end

  def destroy
    group = @group
    @group.destroy

    render json: GroupSerializer.new(group).to_json, status: :ok
  end

  private

  def get_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:avoid, :notes, :id, :activity_id, :cohort_id, :activity_date, :student_ids => [])
  end

end
