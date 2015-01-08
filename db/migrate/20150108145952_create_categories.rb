class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string  :name,     null: false
      t.integer :user_id,  null: false

      t.timestamps
    end

    add_index :categories, :user_id
    add_index :categories, [:user_id, :name], unique: true
  end
end
