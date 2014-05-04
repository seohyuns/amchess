class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource


  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_locations = Location.inactive.alphabetical.to_a
  end

  # GET /locations/1
  # GET /locations/1.json
  def show

  end

  # GET /locations/new
  def new
    authorize! :new, @location
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    authorize! :update, @location
  end

  # POST /locations
  # POST /locations.json
  def create
    authorize! :new, @location
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: "#{@location.name} location was added to the system" }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
        authorize! :update, @location
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: "#{@location.name} location was revised in the system" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
            authorize! :destroy, @location
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:Location, :name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :latitude, :longitude, :active)
    end
end
