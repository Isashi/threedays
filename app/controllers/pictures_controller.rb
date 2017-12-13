class PicturesController < ApplicationController
  def destroy
    Picture.find(params[:id]).destroy
    flash[:success] = "Picture deleted"
    redirect_back(fallback_location: root_path)
  end
end