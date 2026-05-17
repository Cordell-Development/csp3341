require "net/http"

# Adapter consumed by WeatherClient.rb
module Weather
  class OpenMeteoClient
    API_URL = "https://api.open-meteo.com/v1/forecast"
    DEFAULT_PARAMS = {
      current_day: {
        hourly: "temperature_2m,relative_humidity_2m,rain",
        current: "temperature_2m,relative_humidity_2m",
        timezone: "auto",
        forecast_days: "1"
      },
      forecast: {
        daily: "temperature_2m_max,temperature_2m_min,rain_sum,relative_humidity_2m_mean",
        timezone: "auto"
      },
      history: {
        daily: "temperature_2m_max,temperature_2m_min,rain_sum,relative_humidity_2m_mean",
        timezone: "auto",
        past_days: "7",
        forecast_days: "0"
      }
    }.freeze
    private_constant :API_URL, :DEFAULT_PARAMS

    class << self
      def current_day(location, user) = fetch(:current_day, location, user)
      def forecast(location, user)    = fetch(:forecast, location, user)
      def history(location, user)     = fetch(:history, location, user)

      private

      def fetch(name, location, user)
        params = DEFAULT_PARAMS[name].merge({
          latitude: location.latitude,
          longitude: location.longitude
        })

        cache_key = "open_meteo:#{name}:#{location.id}"
        cache_hit = Rails.cache.exist?(cache_key)

        data = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
          uri = URI(API_URL)
          uri.query = URI.encode_www_form(params)
          res = Net::HTTP.get_response(uri)
          raise "Open-Meteo error: #{res.code}\n#{res.body}" unless res.is_a?(Net::HTTPSuccess)
          JSON.parse(res.body)
        end

        ApiUsage.create!(user: user, location: location, endpoint: name.to_s, cache_hit: cache_hit)
        data
      end
    end
  end
end
