class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :overdue, :integer
  end
end
