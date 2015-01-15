class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.integer :entry_id, null: false
      t.integer :feed_id,  null: false

      t.timestamps
    end

    add_index :feed_entries, :entry_id
    add_index :feed_entries, :feed_id
    add_index :feed_entries, [:entry_id, :feed_id], unique: true
  end
end
