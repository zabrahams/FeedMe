class RemoveUrlUniquenessFromFeeds < ActiveRecord::Migration
  def up
    remove_index :feeds, :url
  end

  def down
    add_index :feeds, :url, unique: true
  end
end
