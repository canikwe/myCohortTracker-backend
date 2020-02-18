class Student < ApplicationRecord
  belongs_to :cohort
  has_many :student_groups
  has_many :groups, through: :student_groups
end
