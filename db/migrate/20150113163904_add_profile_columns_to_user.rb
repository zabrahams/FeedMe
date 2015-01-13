class AddProfileColumnsToUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string      :activation_token, null: false
      t.text        :description
      t.string      :fname
      t.string      :lname
      t.attachment  :image
    end
  end

  def down
    change_table :users do |t|
      t.remove :activation_token
      t.remove :description
      t.remove :fname
      t.remove :lname
    end

    remove_attachment :users, :image
  end
end
