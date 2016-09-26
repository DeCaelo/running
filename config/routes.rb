Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  patch "events/:id/add_pictures" => "events#add_pictures", as: "add_pictures"

  resources :events do
    resources :participations, only: [:create]
    resources :messages, only: [:create]
  end
  get '/profile' => 'users#profile'
  post '/users/random' => 'users#random'
  resources :users, only: [ :edit, :update, :destroy ]
  resources :participations, only: [:update, :destroy]
  resources :activities, only: [:index]
  mount Attachinary::Engine => "/attachinary"
  get 'activities/:id/done' => "activities#mark_as_read", as: :read_activity
end
