Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Routes for assignments and uploading files
  resources :assignments, only: [:index, :show, :new, :create, :destroy] do
    # Custom route for file upload
    post 'upload', to: 'assignments#upload', as: 'upload'
  end

  # Route for admin to view all uploads (if needed)
  # You may want to adjust this route if admins have a different way to view uploads
  # resources :uploads, only: :index

  root "assignments#index"

  # Health check route (optional, for checking app health)
  get "up" => "rails/health#show", as: :rails_health_check
end
