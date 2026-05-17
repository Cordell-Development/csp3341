class ApiUsagesController < ApplicationController
  before_action :set_api_usage, only: %i[ show edit update destroy ]

  # GET /api_usages or /api_usages.json
  def index
    @api_usages = ApiUsage.all
  end

  # GET /api_usages/1 or /api_usages/1.json
  def show
  end

  # GET /api_usages/new
  def new
    @api_usage = ApiUsage.new
  end

  # GET /api_usages/1/edit
  def edit
  end

  # POST /api_usages or /api_usages.json
  def create
    @api_usage = ApiUsage.new(api_usage_params)

    respond_to do |format|
      if @api_usage.save
        format.html { redirect_to @api_usage, notice: "Api usage was successfully created." }
        format.json { render :show, status: :created, location: @api_usage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @api_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_usages/1 or /api_usages/1.json
  def update
    respond_to do |format|
      if @api_usage.update(api_usage_params)
        format.html { redirect_to @api_usage, notice: "Api usage was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @api_usage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @api_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_usages/1 or /api_usages/1.json
  def destroy
    @api_usage.destroy!

    respond_to do |format|
      format.html { redirect_to api_usages_path, notice: "Api usage was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_usage
      @api_usage = ApiUsage.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def api_usage_params
      params.expect(api_usage: [ :user_id, :location_id, :endpoint, :cache_hit ])
    end
end
