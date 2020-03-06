class Cohort < ApplicationRecord
  has_many :students
  has_many :cohort_activities
  has_many :activities, through: :cohort_activities
  has_many :groups
end
