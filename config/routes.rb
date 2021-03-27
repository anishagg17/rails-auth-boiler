Rails.application.routes.draw do
  root 'pages#index'
  
  namespace :api do
    resources :users
  end

  get '*path', to: 'pages#index', via: :all
end
