class CreateCohortActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :cohort_activities do |t|
      t.integer :activity_id
      t.integer :cohort_id

      t.timestamps
    end
  end
end
