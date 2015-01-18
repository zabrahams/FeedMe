class AddResetTokenToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :reset_token
    end
  end
end
