Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/profile' => 'users#profile'
  resources :users, only: [ :edit, :update, :destroy ]
  resources :events
  resources :activities, only: [:index]
  mount Attachinary::Engine => "/attachinary"
  get 'activities/:id/done' => "activities#mark_as_read", as: :read_activity
end
