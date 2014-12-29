class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @documents = Document.all
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    if current_submitter && current_submitter.documents.count > Document::MAX_DOCUMENTS
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
    @document.destroy
    flash.notice = @document.title + " was successfully removed."
    redirect_to submissions_show_path
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:title, :user_id, :style, :file, :user_id)
    end
end
