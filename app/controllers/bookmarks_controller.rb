#  bookmarks_controller.rb 
#  Author: Danielle Fudger
#  Created: April, 2014
#
#  This controller creates the bookmarks and its relations to site and tags
#  it also includes the CRUD methods for the user to interact with the views.
  
class BookmarksController < ApplicationController

	def new
	end

	def index
		@bookmarks = Bookmark.all
	end

	def create
		siteDomain = params[:bookmark][:siteID]
		
		#Check if the site is already in the db, if not add it
		if(!(Site.find_by url: siteDomain))
			@site = Site.new(url: siteDomain)
			@site.save
		end
		
		#Save the id to the bookmark siteID param
		currSiteID = (Site.find_by url: siteDomain).id
		params[:bookmark][:siteID] = currSiteID

		#Add the bookmark and parameters to the database
		@bookmark = Bookmark.new(bookmark_params)
		@bookmark.save
		
		#Save relationship between site and this bookmark
		@site = Site.find_by url: siteDomain
		@site.bookmarks << @bookmark

		#Parse Tags
		tagsArray = (params[:bookmark][:tagList]).split(',')

		#Add each tag to the table
		tagsArray.each do |c|
			#Check if tag already in db
			if(!(Tag.find_by title: c))
				@currTag = Tag.new(title: c)
				@currTag.save				
			end

			@bookmark.tags << (Tag.find_by title: c)
		end
	
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
