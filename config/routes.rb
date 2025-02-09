Rails.application.routes.draw do
  scope "/api", defaults: { format: :json } do
    post :reseed, to: "application#reseed", constraints: lambda { |req| Rails.env.development? }

    resources :items do
      post :sync_listings, on: :member, to: "items/listings_sync#create"
    end

    resources :listings, only: [ :index ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
