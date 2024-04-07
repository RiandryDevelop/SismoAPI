# Rails.application.routes.draw do
#   namespace :api do
#     get 'comments/create'
#     get 'features/index'
#   end
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Defines the root path route ("/")
#   # root "posts#index"
# end

# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    resources :features, only: [:index]
    post 'comments', to: 'comments#create'
  end
end
