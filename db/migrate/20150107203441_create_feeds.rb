class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name, null: false
      t.string :url,  null: false

      t.timestamps
    end

    add_index :feeds, :name, unique: true
    add_index :feeds, :url,  unique: true
  end
end
