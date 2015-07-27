Rails.application.routes.draw do

  get "/" => "home#index"

  get "/users/search" => "users#search"
  devise_for :users,  path: "",
                      path_names: {sign_in: "login", sign_up: "signup", sign_out: "logout"}

  resources :users, only: [:show, :edit, :update]

  post "/users/:id/follow" => "followings#create"
  delete "/users/:id/unfollow" => "followings#destroy"


end
