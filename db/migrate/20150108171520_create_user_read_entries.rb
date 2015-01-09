class CreateUserReadEntries < ActiveRecord::Migration
  def change
    create_table :user_read_entries do |t|
      t.integer :user_id,    null: false
      t.integer :entry_id,   null: false

      t.timestamps
    end

    add_index :user_read_entries, :user_id
    add_index :user_read_entries, :entry_id
    add_index :user_read_entries, [:user_id, :entry_id], unique: true
  end
end
