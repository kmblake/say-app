class CommentsController < ApplicationController
	def create
		@comment = Comment.new	
		@comment.user_id = current_user.id
		@comment.comment_text = params[:comment][:comment_text]
    	
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
      @artwork = artwork.find(params[:artwork_id])
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

			# @comment.artwork_id = params[:artwork_id]
			# @artwork = Artwork.find(params[:artwork_id])
			# if @comment.save
			# 	redirect_to artwork_path(@artwork)
			# else
			# 	if Rating.exists?(:user_id => current_user.id, :artwork_id => @artwork.id)
   #    				@rating = Rating.find_by_user_id_and_document_id(current_user.id, @artwork.id)
   #  			else
   #    				@rating = Rating.new
   #  			end
			# 	render :template => 'artworks/show'
			end
		end				
	end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @submission 
    if @comment.document_id
      @submission = Document.find(@comment.document_id)
    else 
      Artwork.find(@comment.artwork_id)
    end
    respond_to do |format|
      format.js {
       render :template => "comments/update-comments.js.erb"
      }
    end
    # response here
  end

end
