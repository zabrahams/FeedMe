class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string   :guid,         null: false
      t.string   :title
      t.string   :link
      t.string   :json,         null: false
      t.datetime :published_at, null: false
      t.integer  :feed_id,      null: false

      t.timestamps
    end

    add_index :entries, :guid, unique: true
  end
end
