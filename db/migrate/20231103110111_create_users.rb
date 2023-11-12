class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false, primary_key: :name do |t|
      t.string :name, null: false
      t.string :email
      t.string :password_digest
      t.integer :pending
      t.integer :scheduled
      t.integer :done

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
