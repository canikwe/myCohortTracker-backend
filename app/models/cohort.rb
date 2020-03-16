class Cohort < ApplicationRecord
  has_many :students
  # has_many :cohort_activities
  has_many :groups
  has_many :activities, through: :groups
end
