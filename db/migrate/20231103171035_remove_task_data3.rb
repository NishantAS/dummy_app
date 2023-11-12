class RemoveTaskData3 < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :done
  end
end
