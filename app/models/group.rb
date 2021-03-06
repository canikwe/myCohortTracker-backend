class Group < ApplicationRecord
  belongs_to :activity
  has_many :student_groups, dependent: :destroy
  has_many :students, through: :student_groups
  belongs_to :cohort

  def activity_name
    self.activity.name
  end

end
