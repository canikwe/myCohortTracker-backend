class CreateCohorts < ActiveRecord::Migration[5.2]
  def change
    create_table :cohorts do |t|
      t.string :batch
      t.string :name
      t.integer :batch_id
      t.integer :current_mod

      t.timestamps
    end
  end
end
