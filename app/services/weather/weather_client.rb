# Dependency Injection Weather Client module -> set in config/weather.yml
# Using module as WeatherClient is a singleton and not instantiable.
module Weather
  module WeatherClient
    class << self
      def fetch_all(location, user) = adapter.fetch_all(location, user)

      private
      def adapter
        @adapter ||= Rails.configuration.weather_adapter.constantize
      end
    end
  end
end
