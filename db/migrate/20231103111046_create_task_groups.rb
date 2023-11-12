class CreateTaskGroups < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :name, unique: true
    
    create_table :task_groups, id: false, primary_key: :name do |t|
      t.string :name, null: false
      t.string :user_name, null: false
      t.text :description

      t.timestamps
    end

    add_foreign_key :task_groups, :users, column: :user_name, primary_key: :name
  end
end
