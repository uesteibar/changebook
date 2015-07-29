Rails.application.routes.draw do

  get "/", to: "home#index"

  devise_for :users, path: "",
                    path_names: {sign_in: "login", sign_up: "signup", sign_out: "logout"}

  resources :users, only: [:show, :edit, :update] do
    collection do
      get "search"
    end
    resources :ownerships, only: [:destroy]
  end

  resources :ownerships, only: [:create]

  resources :books, only: [:show, :new, :create]


  get "/api/books", to: "books#all"
  get "/api/books/:id", to: "books#one"
  get "/api/books/search/:term", to: "books#search"

  post "/users/:id/follow", to: "followings#create"
  delete "/users/:id/unfollow", to: "followings#destroy"

end
