class CommentsController < ApplicationController
	def create
		@comment = Comment.new	
		@comment.user_id = current_user.id
		@comment.comment_text = params[:comment][:comment_text]
    @comment.title_suggestion = params[:comment][:title_suggestion]
    	
		if !params[:document_id].nil?
	    	@comment.document_id = params[:document_id]
	    	@document = Document.find(params[:document_id])
        @submission = @document
			if @comment.save 
        respond_to do |format|
          format.js {
           render :template => "comments/update-comments.js.erb"
          }
        end
      else
        render json: { errors: @comment.errors.full_messages }, status: 422
				# redirect_to document_path(@document)
      end
		elsif !params[:artwork_id].nil?
      @comment.artwork_id = params[:artwork_id]
      @artwork = Artwork.find(params[:artwork_id])
      @submission = @artwork
      if @comment.save 
        respond_to do |format|
          format.js {
           render :template => "comments/update-comments.js.erb"
          }
        end
      else
        render json: { errors: @comment.errors.full_messages }, status: 422
        # redirect_to document_path(@document)
      end
		end				
	end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.document_id
      @submission = Document.find(@comment.document_id)
    else 
      @submission = Artwork.find(@comment.artwork_id)
    end
    @comment.destroy
    respond_to do |format|
      format.js {
       render :template => "comments/update-comments.js.erb"
      }
    end
    # response here
  end

end
