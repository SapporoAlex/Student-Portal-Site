Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :assignments, only: [:index, :show, :new, :create, :destroy] do
    # Custom route for file upload
    post 'upload', to: 'assignments#upload', as: 'upload'
    resources :uploads, only: [:new, :create]  # Add nested routes for uploads
  end

  root "assignments#index"

  # Optional: Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
