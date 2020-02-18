class StudentGroup < ApplicationRecord
  belongs_to :student
  belongs_to :group
  # validates :student_id, uniqneness: {scope: :group_id}
end
