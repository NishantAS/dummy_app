class RemoveTaskData2 < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :scheduled
  end
end
