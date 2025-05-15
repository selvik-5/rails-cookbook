Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Categories with nested bookmarks for new/create
  root "categories#index"
  resources :categories, except: [:edit, :update, :destroy] do
    resources :bookmarks, only: [:new, :create]
  end

  # Top-level bookmark destroy route
  resources :bookmarks, only: [:destroy]
end
