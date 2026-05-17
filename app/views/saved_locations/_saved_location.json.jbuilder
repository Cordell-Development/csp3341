json.extract! saved_location, :id, :user_id, :location_id, :is_current_location, :created_at, :updated_at
json.url saved_location_url(saved_location, format: :json)
