Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: "pages#index"

  resources "games", only: [:new, :show, :create]
  post "/games/:id/turn", to: "games#turn"
  post "games/:id/stacks", to: "games#new_stack"

  get "/friends", to: "friends#list"

  namespace :admin do
    get "/test", to: "test#show"
  end

  namespace :api do
    namespace :v1 do
      post "/auth/create", to: "auth#create"
    end
  end
end
