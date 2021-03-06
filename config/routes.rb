Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources "users"
  resources "posts" do
    resources "comments"
    member do
      put "like", to: "posts#upvote"
    end
  end
end
