class RatingsController < ApplicationController
	def create
		@rating = Rating.new	
    	@rating.document_id = params[:document_id]
    	@rating.user_id = current_user.id
		@rating.rating_val = params[:rating][:rating_val]
		@document = Document.find(params[:document_id])
		if @rating.save
			redirect_to document_path(@document)
		end
	end
end
