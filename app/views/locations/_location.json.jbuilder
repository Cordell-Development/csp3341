json.extract! location, :id, :city_name, :latitude, :longitude, :is_blacklisted, :created_at, :updated_at
json.url location_url(location, format: :json)
