class BookmarksController < ApplicationController

	def new
	end

	def create

		temp = params[:bookmark][:siteID]
		
		#Check if the site is already in the db
		if(!(Site.find_by url: params[:bookmark][:siteID]))
			@site = Site.new(url: params[:bookmark][:siteID])
			@site.save
			flash[:notice] = @site.inspect
		end
		#Save the id to the bookmark siteID param
		currSiteID = Site.find_by url: params[:bookmark][:siteID]
		params[:bookmark][:siteID] = currSiteID

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
