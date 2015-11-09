json.board do
  json.partial! 'api/board/piece', collection: @board, as: :piece
end
json.messages do
  json.array! @message
end
