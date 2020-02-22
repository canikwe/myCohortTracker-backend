class Group < ApplicationRecord
  belongs_to :activity
  has_many :student_groups
  has_many :students, through: :student_groups

  def activity_name
    self.activity.name
  end

end
