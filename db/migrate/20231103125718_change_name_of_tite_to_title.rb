class ChangeNameOfTiteToTitle < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :tite, :title
  end
end
