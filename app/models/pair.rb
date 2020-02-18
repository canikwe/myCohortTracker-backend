class Pair < ApplicationRecord
  belongs_to :first_student, class_name: :Student, foreign_key: 's1_id'
  belongs_to :second_student, class_name: :Student, foreign_key: 's2_id'
end
