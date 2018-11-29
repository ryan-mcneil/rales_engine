Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'most_revenue#index'
      end
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
end
