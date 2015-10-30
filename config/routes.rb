Rails.application.routes.draw do
  root to: "static_page#index"

  namespace :api, default: { format: 'json'} do
    get 'game/new_game', :to => 'game#new_game'
    post 'board/valid_moves', :to => 'board#valid_moves'
    get 'board/play_turn', :to => 'board#play_turn'
  end
end
