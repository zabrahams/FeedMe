class ChangeEntryJsonToText < ActiveRecord::Migration
  def up
    change_column :entries, :json, :text
  end

  def down
    change_column :entries, :json, :string
  end
end
