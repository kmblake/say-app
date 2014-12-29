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

	def update
		@rating = Rating.find_by_user_id_and_document_id(current_user.id, params[:document_id])
		@rating.rating_val = params[:rating][:rating_val]
		@document = Document.find(params[:document_id])
		if @rating.save 
			redirect_to document_path(@document)
		end
	end
end
