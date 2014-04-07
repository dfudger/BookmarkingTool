class CreateBookmarkTags < ActiveRecord::Migration
  def change
    create_table :bookmarks_tags do |t|
      #t.string :bookmarkID
      #t.string :tagID
      t.belongs_to :bookmark
      t.belongs_to :tag
      t.timestamps
    end
  end
end
