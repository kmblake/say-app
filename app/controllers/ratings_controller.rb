class RatingsController < ApplicationController
	def create
		@rating = Rating.new	
    	@rating.user_id = current_user.id
		@rating.rating_val = params[:rating][:rating_val]
		if !params[:document_id].nil?
			@rating.document_id = params[:document_id]
			@document = Document.find(params[:document_id])
			if @rating.save 
				redirect_to document_path(@document)
			end
		elsif !params[:artwork_id].nil?
			@rating.artwork_id = params[:artwork_id]
			@artwork = Artwork.find(params[:artwork_id])
			if @rating.save
				redirect_to artwork_path(@artwork)
			end
		end
	end

	def update
		if !params[:document_id].nil?
			@rating = Rating.find_by_user_id_and_document_id(current_user.id, params[:document_id])
			@rating.rating_val = params[:rating][:rating_val]
			@document = Document.find(params[:document_id])
			if @rating.save 
				redirect_to document_path(@document)
			end
		elsif !params[:artwork_id].nil?
			@rating = Rating.find_by_user_id_and_artwork_id(current_user.id, params[:artwork_id])
			@rating.rating_val = params[:rating][:rating_val]
			@artwork = Artwork.find(params[:artwork_id])
			if @rating.save 
				redirect_to artwork_path(@artwork)
			end
		end
	end
end
