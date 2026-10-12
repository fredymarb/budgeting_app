Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :budgets, only: [ :show ] do
    resources :accounts, only: [ :index, :show, :new, :create, :edit, :update ] do
      member do
        patch :close
      end
    end

    resources :category_groups do
      resources :categories do
        resources :monthly_allocations, only: [ :create, :update ]
      end
    end

    resources :payees

    resources :transactions
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "budgets#show"
end
