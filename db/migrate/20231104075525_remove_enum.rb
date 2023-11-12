class RemoveEnum < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :status
    execute <<-SQL
    DROP TYPE task_status;
  SQL
  end
end
