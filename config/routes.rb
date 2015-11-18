Rails.application.routes.draw do
  root to: "static_page#index"

  namespace :api, default: { format: 'json'} do
    get 'game', :to => 'game#new_game'
    patch 'game', :to => 'game#continue_game'
    get 'board', :to => 'board#valid_moves'
    patch 'board', :to => 'board#play_turn'
  end
end
