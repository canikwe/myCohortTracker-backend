class PairsController < ApplicationController

  def index
    render json: Pair.all
  end

  def create
    student_ids = params[:student_ids]

    if student_ids.count == 1
      pair = Pair.create(s1_id: student_ids[0], s2_id: student_ids[0])
      pair.update(pair_params)
    else
      student_ids.each do |s1|
        student_ids.each do |s2|
          if s1 != s2
            pair = Pair.create(s1_id: s1, s2_id: s2)
            pair.update(pair_params)
          end
        end
      end
    end
    # pair_params[:student_ids].each do |id|
    render json: Student.all.to_json(serializer_options)
  end

  private

  def pair_params
    params.require(:pair).permit(:name, :student_ids => [])
  end

# copies from StudentsController
  def serializer_options
    {include: {:pairs => {except: [:created_at, :updated_at]}}, except: [:created_at, :updated_at]}
  end
end
