json.extract! card, :id, :name, :number, :cvv, :expiry_mm, :expiry_yy, :created_at, :updated_at
json.url card_url(card, format: :json)
