json.board do
  json.partial! 'api/piece', collection: @pieces, as: :piece
end
json.messages do
  json.array! @messages
end
