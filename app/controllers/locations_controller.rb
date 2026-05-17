class LocationsController < ApplicationController
    def index
      @query = params[:q].to_s.strip
      @locations = if @query.length >= 2
        Location.where(blacklisted: false)
                .where("city_name LIKE ?", "#{@query}%")
                .order(:city_name)
                .limit(20)
      else
        Location.none
      end
      @saved_locations = SavedLocation.where(user: Current.user)
    end
end
