class CommentsController < ApplicationController
	def create
		@comment = Comment.new	
		@comment.user_id = current_user.id
		@comment.comment_text = params[:comment][:comment_text]
    	
		if !params[:document_id].nil?
	    	@comment.document_id = params[:document_id]
	    	@document = Document.find(params[:document_id])
			if @comment.save 
				redirect_to document_path(@document)
			else
				if Rating.exists?(:user_id => current_user.id, :document_id => @document.id)
      				@rating = Rating.find_by_user_id_and_document_id(current_user.id, @document.id)
    			else
      				@rating = Rating.new
    			end
				render :template => 'documents/show'
			end
		elsif !params[:artwork_id].nil?
			@comment.artwork_id = params[:artwork_id]
			@artwork = Artwork.find(params[:artwork_id])
			if @comment.save
				redirect_to artwork_path(@artwork)
			else
				if Rating.exists?(:user_id => current_user.id, :artwork_id => @artwork.id)
      				@rating = Rating.find_by_user_id_and_document_id(current_user.id, @artwork.id)
    			else
      				@rating = Rating.new
    			end
				render :template => 'artworks/show'
			end
		end				
	end
end
