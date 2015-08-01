Rails.application.routes.draw do

  get "/", to: "home#index"

  get "/timeline", to: "events#index"

  devise_for :users, path: "",
                    path_names: {sign_in: "login", sign_up: "signup", sign_out: "logout"}

  resources :users, only: [:show, :edit, :update]


  resources :ownerships, only: [:new, :create, :update, :destroy] do
    resources :transfers, only: [:create]
  end
  resources :transfers, only: [:destroy]
  put "/transfers/:id/accept", to: "transfers#accept"

  resources :books, only: [:show, :create] do
    resources :recommendations, only: [:new, :create, :destroy]
  end

  resources :notifications, only: [:index]
  put "/notifications/:id/mark-read", to: "notifications#mark_read"

  resources :events, only: [:index]

  get "/search", to: "search#search"
  get "/api/books", to: "books#all"
  get "/api/books/:id", to: "books#one"
  get "/api/books/search/:term", to: "books#search"

  post "/users/:id/follow", to: "followings#create"
  delete "/users/:id/unfollow", to: "followings#destroy"

end
