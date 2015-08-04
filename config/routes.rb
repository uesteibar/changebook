Rails.application.routes.draw do

  get "/", to: "home#index"

  get "/dashboard", to: "dashboard#index"

  devise_for :users, path: "",
  path_names: {sign_in: "login", sign_up: "signup", sign_out: "logout"}

  resources :users, only: [:show, :edit, :update] do
    member do
      post "follow", to: "followings#create"
      delete "unfollow", to: "followings#destroy"
    end
    resources :liked_genres, only: [:create]
  end

  resources :ownerships, only: [:new, :create, :update, :destroy] do
    resources :transfers, only: [:create]
  end
  resources :transfers, only: [:destroy]
  put "/transfers/:id/accept", to: "transfers#accept"

  resources :books, only: [:index, :show, :create] do
    resources :recommendations, only: [:new, :create, :destroy]
  end

  post "/recommendations/:id/thank", to: "thanks#create"

  resources :notifications, only: [:index]
  put "/notifications/:id/mark-read", to: "notifications#mark_read"

  resources :events, only: [:index]

  get "/search", to: "search#search"

  namespace :api do
    namespace :v1 do
      get "books/search", to: "books#search"
    end
  end

end
