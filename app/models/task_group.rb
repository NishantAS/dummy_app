class TaskGroup < ApplicationRecord
  belongs_to :user, primary_key: :name, foreign_key: :user_name
  has_many :tasks, primary_key: :name, foreign_key: :group_name

  self.primary_key = [:name, :user_name]
end
