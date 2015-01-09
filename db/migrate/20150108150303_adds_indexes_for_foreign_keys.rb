class AddsIndexesForForeignKeys < ActiveRecord::Migration
  def change
    add_index :entries, :feed_id
    add_index :user_feeds, :user_id
    add_index :user_feeds, :feed_id
  end
end
