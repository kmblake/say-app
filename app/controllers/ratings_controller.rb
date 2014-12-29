class RatingsController < ApplicationController
	def create
		@rating = Rating.find(params[:id])
		@document = @rating.document_id
		if @rating.save
			redirect_to document_path(@document)
		end
	end
end
