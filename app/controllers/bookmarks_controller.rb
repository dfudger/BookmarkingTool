class BookmarksController < ApplicationController

	def new
	end

	def create
		
		

		@bookmark = Bookmark.new(bookmark_params)
		@bookmark.save
		redirect_to @bookmark
	end

	def show
		@bookmark = Bookmark.find(params[:id])
	end

	private
 	def bookmark_params
 		params.require(:bookmark).permit(:url, :title, :description, :siteID)
  	end

end
