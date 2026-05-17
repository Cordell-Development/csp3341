class SavedLocationsController < ApplicationController
  before_action :set_saved_location, only: %i[ destroy ]

  def index
    @saved = Current.user.saved_locations.includes(:location)
    @weather = @saved.each_with_object({}) do |sl, hash|
      hash[sl.location.id] = Weather::WeatherClient.fetch_all(sl.location, Current.user)
    end
  end

  # POST /saved_locations or /saved_locations.json
  def create
    @saved_location = SavedLocation.new(saved_location_params)

    respond_to do |format|
      if @saved_location.save
        format.html { redirect_to @saved_location, notice: "Saved location was successfully created." }
        format.json { render :show, status: :created, location: @saved_location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saved_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_locations/1 or /saved_locations/1.json
  def destroy
    @saved_location.destroy!

    respond_to do |format|
      format.html { redirect_to saved_locations_path, notice: "Saved location was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_location
      @saved_location = SavedLocation.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def saved_location_params
      params.expect(saved_location: [ :user_id, :location_id, :is_current_location ])
    end
end
