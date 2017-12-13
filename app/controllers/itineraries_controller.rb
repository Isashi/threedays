class ItinerariesController < ApplicationController
  def new
  	@itinerary = Itinerary.new
    @itineraryplace = ItineraryPlace.new
    @places = Place.all
  end

  def index
    @itinerary = Itinerary.paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    Itinerary.find(params[:id]).destroy
    flash[:success] = "Itinerary deleted"
    redirect_to itineraries_url
  end

  def edit
    @itinerary = Itinerary.find(params[:id])
  end  

  def update
    @itinerary = Itinerary.find(params[:id])
    if @itinerary.update_attributes(itineraries_params)
      ItineraryPlace.where(itinerary_id: @itinerary.id).destroy_all
      params[:itinerary][:id].each do |placeid|
        ItineraryPlace.create(:place_id => placeid, :itinerary_id => @itinerary.id)
      end      
      flash[:success] = "Itinerary updated"
      redirect_to @itinerary
    else
      render 'edit'
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def create
  	@itinerary = Itinerary.new(itineraries_params)
    @itinerary.user_id = current_user.id
  	if @itinerary.save
      params[:itinerary][:id].each do |placeid|
        ItineraryPlace.create(:place_id => placeid, :itinerary_id => @itinerary.id)
      end
  		redirect_to root_url
  		flash[:notice] = "Itinerary created!"
  	else
  		redirect_to new_place_path
  		flash[:alert] = "Itinerary not created!"
  	end
  end

  private

  	def itineraries_params
  		params.require(:itinerary).permit(:name, :id)
  	end
end
