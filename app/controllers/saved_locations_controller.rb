class SavedLocationsController < ApplicationController
  def index
    @saved = Current.user.saved_locations.includes(:location)
    @weather = @saved.each_with_object({}) do |sl, hash|
      hash[sl.location.id] = Weather::WeatherClient.fetch_all(sl.location, Current.user)
    end
  end

  def create
    location = Location.find(params[:location_id])
    return redirect_to(locations_path, alert: "That location is blacklisted") if location.blacklisted?

    Current.user.saved_locations.find_or_create_by!(location: location)
    redirect_to root_path, notice: "Added #{location.city_name}."
  end

  def destroy
    saved = Current.user.saved_locations.find(params[:id])
    location_name = saved.location.city_name

    saved.destroy!
    redirect_to root_path, notice: "Removed #{location_name}"
  end
end
