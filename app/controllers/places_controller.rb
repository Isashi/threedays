class PlacesController < ApplicationController
  def new
  	@place = Place.new
  end

  def index
    @places = Place.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @comment.place_id = @place.id
    
    if current_user then @comment.user_id = current_user.id end
  end

  def create
  	@place = current_user.places.build(places_params)
  	if @place.save
      
      if params[:images]
        #===== The magic is here ;)
        params[:images].each { |image|
          @place.pictures.create(image: image)
        }
      end

  		redirect_to root_url
  		flash[:notice] = "Place created!"
  	else
  		redirect_to new_place_path
  		flash[:alert] = "Places not created!"
  	end
  end

  def destroy
    Place.find(params[:id]).destroy
    flash[:success] = "Place deleted"
    redirect_to places_url
  end

  def edit
    @place = Place.find(params[:id])
  end  

  def update
    @place = Place.find(params[:id])
    if @place.update_attributes(places_params)     
        if params[:images]
        #===== The magic is here ;)
          params[:images].each { |image|
            @place.pictures.create(image: image)
          }
        end
      flash[:success] = "Place updated"
      redirect_to @place
    else
      render 'edit'
    end
  end

  private

  	def places_params
  		params.require(:place).permit(:title, :description, :lat, :long)
  	end

end
