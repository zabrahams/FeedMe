class IncreaseLengthOfGuidStringOnEntries < ActiveRecord::Migration
  def up
    change_column :entries, :guid, :text
  end

  def down
    change_column :entries, :guild, :string
  end
end
