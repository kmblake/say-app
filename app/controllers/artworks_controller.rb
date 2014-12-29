class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @artworks = Artwork.all
    respond_with(@artworks)
  end

  def show
    respond_with(@artwork)
  end

  def new
    if current_user.artworks.count > Artwork::MAX_ARTWORKS
      flash.alert = "You have already uploaded the maximum number of art submissions.  In order to upload a new submission, you must remove an existing one. To remove a submission, go to \"My Submissions\" and select the artwork you would like to remove."
      redirect_to :back
    else 
      @artwork = Artwork.new
      respond_with(@artwork)
    end
  end

  def edit
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.save
    respond_with(@artwork)
  end

  def update
    @artwork.update(artwork_params)
    respond_with(@artwork)
  end

  def destroy
    @artwork.destroy
    flash.notice = @artwork.title + " was successfully removed."
    redirect_to submissions_show_path
  end

  private
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    def artwork_params
      params.require(:artwork).permit(:title, :user_id, :image)
    end
end
