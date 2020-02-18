class CreatePairs < ActiveRecord::Migration[5.2]
  def change
    create_table :pairs do |t|
      t.integer :s1_id
      t.integer :s2_id
      t.integer :mod
      t.string :name
      t.boolean :avoid
      t.string :category

      t.timestamps
    end
  end
end
