json.extract! api_usage, :id, :user_id, :location_id, :endpoint, :cache_hit, :created_at, :updated_at
json.url api_usage_url(api_usage, format: :json)
