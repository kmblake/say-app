json.array!(@artworks) do |artwork|
  json.extract! artwork, :id, :title, :user_id
  json.url artwork_url(artwork, format: :json)
end
