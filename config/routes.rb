Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get "/login", to: "sessions#new", as: "new_session"
  resource :session, only: %i[ create destroy ]
  
  get "/forgot_password", to: "password_resets#new", as: "new_password_reset"
  get "/reset_password", to: "password_resets#edit", as: "edit_password_reset"
  resource :password_reset, only: %i[ create update ]

  resource :email_confirmation, only: %i[ create ]
  get "/email_confirmation", to: "email_confirmations#update"

  resources :users, only: %i[ show new create ], param: :name do
    resources :task_groups, only: %i[ index show ], param: :name do
      resources :tasks, only: %i[ show ]
    end
  end

  patch "/profile/change_password", to: "passwords#update", as: "user_password_change"
  put "/profile/change_password", to: "passwords#update"

  # resources :users, only: %i[ show index ], param: :name

  resources :task_groups, only: %i[ new edit create update destroy ], param: :name

  resources :tasks, only: %i[ index new edit create update destroy ]

  post "/tasks/:id/done", to: "tasks#done", as: "done_task"
  post "/task_groups/:name/done", to: "task_groups#done", as: "done_task_group"

  get "/profile/edit", to: "users#edit", as: "edit_user_profile"
  patch "/profile/edit", to: "users#update"
  put "/profile/edit", to: "users#update"
  post "/user_search", to: "users#search", as: "user_search"
  get "/profile", to: "users#profile", as: "user_profile"
  delete "/profile", to: "users#destroy"

end
