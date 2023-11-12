class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    add_index :task_groups, :name, unique: true

    create_table :tasks do |t|
      t.string :tite
      t.text :description
      t.tsrange :during_time
      t.string :group_name, null: false
    end

    add_foreign_key :tasks, :task_groups, column: :group_name, primary_key: :name
  end
end
