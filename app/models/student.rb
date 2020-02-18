class Student < ApplicationRecord
  belongs_to :cohort
  has_many :pairs, class_name: :Pair, foreign_key: 's1_id'
end
