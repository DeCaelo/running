Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/profile' => 'users#profile'
  resources :users, only: [ :edit, :update, :destroy ]
  resources :participations, only: [:create]
end
