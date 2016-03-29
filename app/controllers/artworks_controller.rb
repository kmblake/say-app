class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @submitters = User.all
    @search = Artwork.search(params[:q])
    @search.sorts = 'ratings_count asc' if @search.sorts.empty?
    @artworks = @search.result.paginate(:page => params[:page], :per_page => 30)
    respond_with(@artworks)
  end

  def show
    if Rating.exists?(:user_id => current_user.id, :artwork_id => @artwork.id)
      @rating = Rating.find_by_user_id_and_artwork_id(current_user.id, @artwork.id)
    else
      @rating = Rating.new
    end
    @comment = Comment.new
    respond_with(@artwork)
  end

  def new
    if current_user.artworks.count >= Artwork::MAX_ARTWORKS
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
    submitter = @artwork.user
    @artwork.destroy
    flash.notice = @artwork.title + " was successfully removed."
    if current_submitter
      redirect_to submissions_show_path
    else 
      redirect_to user_path(submitter)
    end
  end

  def toggle_approved
    @artwork.toggle :accepted
    @artwork.save
    render json: @artwork.accepted
  end

  def toggle_flag
    @artwork.toggle :flag
    @artwork.save
    render json: @artwork.flag
  end

  def gimme_another
    nextArtId = Artwork.gimme_another(current_user)
    if nextArtId == -1
      flash.notice = "Congratulations!  You've rated all available submissions :)"
      redirect_to artworks_path
    else
      redirect_to artwork_path(nextArtId)
    end
  end

  def download
    require 'rubygems'
    require 'zip'
    begin 
      file = Tempfile.new("submissions-temp-#{Time.now}")
      accepted = Artwork.where(accepted: true)
      tempfiles = Array.new()
      Zip::File.open(file.path, Zip::File::CREATE) do |zipfile|
        accepted.each do |art|
          filename = art.title.squish.downcase.tr(" ","_")  <<  art.image.original_filename
          t = Tempfile.new("art")
          puts "Artfile: " + t.path
          puts "Zipfile: " + file.path
          art.image.copy_to_local_file(:original, t.path)
          zipfile.add(filename, t.path)
          tempfiles << t
        end
      end
      send_file file.path, :type => 'application/zip', :disposition => 'attachment', :filename => "artwork.zip"
    ensure
      file.try(:close!)
      for t in tempfiles
        t.try(:close!)
      end
    end
  end

  private
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    def artwork_params
      params.require(:artwork).permit(:title, :user_id, :image)
    end
end
