class RatingsController < ApplicationController
	def create
		@rating = Rating.new	
    	@rating.user_id = current_user.id
		@rating.rating_val = params[:rating][:rating_val]
		if !params[:document_id].nil?
			@rating.rating_val = params[:rating][:rating_val]
			@rating.save 
			render json: @rating
		elsif !params[:artwork_id].nil?
			@rating = Rating.find_by_user_id_and_artwork_id(current_user.id, params[:artwork_id])
			@rating.rating_val = params[:rating][:rating_val]
			@rating.save 
			render json: @rating
		end
	end

	def update

		if !params[:document_id].nil?
			@rating = Rating.find_by_user_id_and_document_id(current_user.id, params[:document_id])
			@rating.rating_val = params[:rating][:rating_val]
			@rating.save 
			render json: @rating
		elsif !params[:artwork_id].nil?
			@rating = Rating.find_by_user_id_and_artwork_id(current_user.id, params[:artwork_id])
			@rating.rating_val = params[:rating][:rating_val]
			@rating.save 
			render json: @rating
		end
	end
end
