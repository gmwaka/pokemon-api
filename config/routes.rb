Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pokemons, only: [:index, :create, :update, :show, :destroy]
    end
  end
end
