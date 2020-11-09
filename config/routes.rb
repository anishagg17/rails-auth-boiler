Rails.application.routes.draw do
  root 'pages#index'
  post '/api/login', to: 'api/users#login'

  namespace :api do
    resources :users
  end

  get '*path', to: 'pages#index', via: :all
end
