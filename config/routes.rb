Rails.application.routes.draw do
  root to: "static_page#index"

  namespace :api, default: { format: 'json'} do
    resources :game, only: [:index]
  end
end
