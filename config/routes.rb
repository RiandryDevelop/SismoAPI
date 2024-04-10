Rails.application.routes.draw do
  namespace :api do
    resources :features, only: [:index]
    resources :comments, only: [:index, :create, :destroy, :update] do
      # Agregar una ruta personalizada para obtener comentarios por feature_id
      get 'feature/:feature_id', action: :index, on: :collection, as: 'by_feature'
    end
  end
end
