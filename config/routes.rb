Rails.application.routes.draw do
  root to: "static_page#index"

  namespace :api, default: { format: 'json'} do
    get 'game/new_game', :to => 'game#new_game'
    get 'game/continue_game', :to => 'game#continue_game'
    post 'board/valid_moves', :to => 'board#valid_moves'
    post 'board/play_turn', :to => 'board#play_turn'
  end
end
