class Admin::LocationsController < Admin::BaseController
  def index
    @query = params[:q].to_s.strip
    @scope = params[:scope]

    locations = Location.all
    locations = locations.where(blacklisted: true) if @scope == "blacklisted"
    locations = locations.where("city_name LIKE ?", "#{@query}%") if @query.length >= 2

    @locations = locations.order(:city_name).limit(100)
    @total_blacklisted = Location.where(blacklisted: true).count
  end

  def update
    location = Location.find(params[:id])
    location.update!(blacklisted: !location.blacklisted)
    redirect_back fallback_location: admin_locations_path, notice: "#{location.city_name} #{location.blacklisted? ? "blacklisted" : "unblacklisted"}"
  end
end
