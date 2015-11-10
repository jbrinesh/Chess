json.board do
  json.partial! 'api/game/piece', collection: @pieces, as: :piece
end
json.messages do
  json.array! @message
end
