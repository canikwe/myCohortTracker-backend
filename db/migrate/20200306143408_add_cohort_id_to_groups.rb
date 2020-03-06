class AddCohortIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :cohort_id, :integer
  end
end
