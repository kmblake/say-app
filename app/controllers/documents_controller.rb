class DocumentsController < ApplicationController
  # before_action :set_document, only: [:show, :edit, :update, :destroy, :toggle_approved]

  respond_to :html

  # load_and_authorize_resource
  skip_authorize_resource only: :download

  def index
    @search = Document.search(params[:q])
    @search.sorts = 'average_rating desc' if @search.sorts.empty?
    @documents = @search.result.paginate(:page => params[:page], :per_page => 30)
    respond_with(@documents)
    
  end

  def show
    if Rating.exists?(:user_id => current_user.id, :document_id => @document.id)
      @rating = Rating.find_by_user_id_and_document_id(current_user.id, @document.id)
    else
      @rating = Rating.new
    end
    @comment = Comment.new
    respond_with(@document)  
  end

  def new
    if current_submitter && current_submitter.documents.count >= Document::MAX_DOCUMENTS
      flash.alert = "You have already uploaded the maximum number of written submissions.  In order to upload a new submission, you must remove an existing one. To remove a submission, go to \"My Submissions\" and select the document you would like to remove."
      redirect_to :back
    else 
      @document = Document.new
      respond_with(@document)
    end
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.save
    respond_with(@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
    # redirect_to document_path(@document)
  end

  def destroy
    submitter = @document.user
    @document.destroy
    flash.notice = @document.title + " was successfully removed."
    if current_submitter
      redirect_to submissions_show_path
    else 
      redirect_to user_path(submitter)
    end
  end

  def toggle_approved
    @document.toggle :accepted
    @document.save
    render json: @document.accepted
  end

  def download
    require 'rubygems'
    require 'zip'
    accepted = Document.where(accepted: true)
    file = Tempfile.new("submissions-temp-#{Time.now}")
    begin 
      Zip::File.open(file.path, Zip::File::CREATE) do |zipfile|
        accepted.each do |doc|
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          filename = doc.title.squish.downcase.tr(" ","_")  << '_' << doc.file.original_filename
          # filename = doc.title.squish.downcase.tr(" ","_")
          t = Tempfile.new("doc")
          doc.file.copy_to_local_file(:original, t.path)
          # zipfile.add(doc.title.squish.downcase.tr(" ","_"), t.path)
          zipfile.add(filename, t.path)
          t.close
        end
      end
      send_file file.path, :type => 'application/zip', :disposition => 'attachment', :filename => "submissions.zip"
    ensure
      file.close
    end
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:title, :user_id, :style, :file, :user_id)
    end
end
