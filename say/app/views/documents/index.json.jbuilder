json.array!(@documents) do |document|
  json.extract! document, :id, :type, :title, :user_id
  json.url document_url(document, format: :json)
end
