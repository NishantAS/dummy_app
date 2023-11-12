class ChnageUsersAndTaskGroups < ActiveRecord::Migration[7.1]
  def change
    drop_table :tasks
    drop_table :task_groups

    create_table :task_groups, id: false, primary_key: %i[ name user_name ] do |t|
      t.string :name, null: false
      t.string :user_name, null: false
      t.text :description

      t.timestamps
    end
    add_index :task_groups, [:name, :user_name], unique: true

    add_foreign_key :task_groups, :users, column: :user_name, primary_key: :name

    create_table :tasks do |t|
      t.string :tite
      t.text :description
      t.tsrange :during_time
      t.string :group_name, null: false
      t.string :user_name, null: false
    end

    add_foreign_key :tasks, :task_groups, column: [:group_name, :user_name], primary_key: [:name, :user_name]
  end
end
