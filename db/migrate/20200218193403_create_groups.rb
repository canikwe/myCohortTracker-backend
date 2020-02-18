class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :notes
      t.boolean :avoid
      t.integer :activity_id

      t.timestamps
    end
  end
end
