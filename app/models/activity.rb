class Activity < ApplicationRecord
  has_many :groups
  has_many :cohort_activities
  has_many :cohorts, through: :cohort_activities
end
