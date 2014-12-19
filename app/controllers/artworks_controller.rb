class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @artworks = Artwork.all
    respond_with(@artworks)
  end

  def show
    respond_with(@artwork)
  end

  def new
    @artwork = Artwork.new
    respond_with(@artwork)
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
    respond_with(@artwork)
  end

  private
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    def artwork_params
      params.require(:artwork).permit(:title, :user_id)
    end
end
