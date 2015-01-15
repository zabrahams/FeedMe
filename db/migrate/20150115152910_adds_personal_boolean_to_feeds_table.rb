class AddsPersonalBooleanToFeedsTable < ActiveRecord::Migration
  def change
    change_table :feeds do |t|
      t.boolean :curated, default: false
      t.integer :curator_id
    end

    add_index :feeds, :curator_id
  end
end
