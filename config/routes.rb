Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: "pages#index"

  resources "games", only: [:new, :show]

  get "/friends", to: "friends#list"

  post "/game_invite", to: "game_invites#create"
  put "/game_invite/accept", to: "game_invites#accept"
end
