Rails.application.routes.draw do
  # route for health check, useful for monitoring the application status
  get "up" => "rails/health#show", as: :rails_health_check

  # crud routes for tasks (create, read, update, delete)
  resources :tasks

  # root route that directs to the index action of taskscontroller
  root "tasks#index"
end
