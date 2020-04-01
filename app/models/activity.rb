class Activity < ApplicationRecord
  has_many :groups, dependent: :destroy
  # has_many :cohort_activities
  has_many :cohorts, through: :groups
end
