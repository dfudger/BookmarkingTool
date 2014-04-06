class CreateBookmarkTags < ActiveRecord::Migration
  def change
    create_table :bookmark_tags do |t|
      t.string :bookmarkID
      t.string :tagID

      t.timestamps
    end
  end
end
