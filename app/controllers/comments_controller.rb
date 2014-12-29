class CommentsController < ApplicationController
	def create
		@comment = Comment.new	
    	@comment.document_id = params[:document_id]
    	@comment.user_id = current_user.id
		@comment.comment_text = params[:comment][:comment_text]
			@document = Document.find(params[:document_id])
		if @comment.save 
			redirect_to document_path(@document)
		end
	end
end
