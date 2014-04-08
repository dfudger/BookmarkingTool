#  sites_controller.rb 
#  Author: Danielle Fudger
#  Created: April, 2014
#
#  This controller created the object that holds all the sites
  
class SitesController < ApplicationController

	def index
		@sites = Site.all
	end
end
