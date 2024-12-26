Rails.application.routes.draw do
  devise_for :users
  resources :assignments do
    member do
      post "upload"
    end
  end
  root to: "assignments#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
