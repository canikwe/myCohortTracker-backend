class AddActivityDateToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :activity_date, :date
  end
end
