# Dependency Injection Weather Client module -> set in config/weather.yml
# Using module as WeatherClient is a singleton and not instantiable.
module Weather
  module WeatherClient
    class << self
      def current_day(location, user) = adapter.current_day(location, user)
      def forecast(location, user) = adapter.forecast(location, user)
      def history(location, user) = adapter.history(location, user)

      private
      def adapter
        @adapter ||= Rails.configuration.weather_adapter.constantize
      end
    end
  end
end
