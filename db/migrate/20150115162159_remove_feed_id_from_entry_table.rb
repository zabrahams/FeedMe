class RemoveFeedIdFromEntryTable < ActiveRecord::Migration
  def up
    change_table :entries do |t|
      t.remove :feed_id
    end
  end

  def down
    change_table :entries do |t|
      t.integer :feed_id, null: false
    end

    add_index :entries, :feed_id
  end
end
