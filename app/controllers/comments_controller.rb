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
			end
		elsif !params[:artwork_id].nil?
			@comment.artwork_id = params[:artwork_id]
			@artwork = Artwork.find(params[:artwork_id])
			if @comment.save
				redirect_to artwork_path(@artwork)
			end
		end				
	end
end
