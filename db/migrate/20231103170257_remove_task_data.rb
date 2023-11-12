class RemoveTaskData < ActiveRecord::Migration[7.1]
  def change
    remove_columns :users, :total, :done, :overdue, :pending
  end
end
