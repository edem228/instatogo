Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources "users" do
    member do
      get :following, :followers
    end
  end
  resources "posts" do
    resources "comments"
    member do
      put "like", to: "posts#upvote"
    end
  end
  resources :relationships,       only: [:create, :destroy]
end