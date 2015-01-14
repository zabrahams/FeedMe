class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.integer :followed_id,  null: false
      t.integer :following_id, null: false

      t.timestamps
    end

    add_index :user_follows, :followed_id
    add_index :user_follows, :following_id
    add_index :user_follows, [:followed_id, :following_id], unique: true
  end

end
