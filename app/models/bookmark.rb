class Bookmark < ActiveRecord::Base
	belongs_to :site
	has_and_belongs_to_many :tags
end
