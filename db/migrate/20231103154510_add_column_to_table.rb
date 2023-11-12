class AddColumnToTable < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :done, :boolean
  end
end
