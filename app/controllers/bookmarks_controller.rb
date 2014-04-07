class BookmarksController < ApplicationController

	def new
	end

	def create

		#Check if the site is already in the db
		if(!(Site.find_by url: params[:bookmark][:siteID]))
			@site = Site.new(url: params[:bookmark][:siteID])
			@site.save
		end
		
		#Save the id to the bookmark siteID param
		currSiteID = (Site.find_by url: params[:bookmark][:siteID]).id
		params[:bookmark][:siteID] = currSiteID

		#Add the bookmark and parameters to the database
		@bookmark = Bookmark.new(bookmark_params)
		@bookmark.save
		
		#Parse Tags
		tagsArray = (params[:bookmark][:tagList]).split(',')

		#Add each tag to the table
		tagsArray.each do |c|
			idForTag = getTagID(c)
			
			@bookTag = BookmarkTag.new(bookmarkID: @bookmark.id, tagID:idForTag)
			@bookTag.save

		end
		flash[:notice] = @bookTag.inspect
		redirect_to @bookmark
	end

	def show
		@bookmark = Bookmark.find(params[:id])
	end

	private
	def getTagID(tag)

		#Check if tag already in db
		if(!(Tag.find_by title: tag))
			@currTag = Tag.new(title: tag)
			@currTag.save
		end

		#Get the id of the tag in the db
		return (Tag.find_by title: tag).id
	end

	private
 	def bookmark_params
 		params.require(:bookmark).permit(:url, :title, :description, :siteID)
  	end

end
