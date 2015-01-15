class FixNamingForUserFollows < ActiveRecord::Migration
  def up
    change_table :user_follows do |t|
      t.remove :followed_id, :following_id
      t.integer :watcher_id, null: false
      t.integer :curator_id, null: false
    end

    add_index :user_follows, :watcher_id
    add_index :user_follows, :curator_id
    add_index :user_follows, [:watcher_id, :curator_id], unique: true
  end

  def down
    change_talbe :user_followers do |t|
      t.remove :watcher_id, :curator_id
      t.integer :followed_id,  null: false
      t.integer :following_id, null: false
    end

    add_index :user_follows, :followed_id
    add_index :user_follows, :following_id
    add_index :user_follows, [:followed_id, :following_id], unique: true
  end
end
