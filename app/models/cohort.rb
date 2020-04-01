class Cohort < ApplicationRecord
  has_many :students, dependent: :destroy
  # has_many :cohort_activities
  has_many :groups, dependent: :destroy
  has_many :activities, through: :groups

  validates :batch_id, uniqueness: true
  validates :batch, presence: true
end
