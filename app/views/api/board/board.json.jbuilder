json.board do
  json.partial! 'api/board/board_piece', collection: @board.pieces , as: :piece
end
json.messages do
  json.array! @message
end
