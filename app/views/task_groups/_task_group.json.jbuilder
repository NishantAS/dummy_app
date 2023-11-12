json.extract! task_group, :id, :name, :description, :user_id, :created_at, :updated_at
json.url task_group_url(task_group, format: :json)
