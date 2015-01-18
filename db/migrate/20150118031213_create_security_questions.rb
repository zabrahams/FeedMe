class CreateSecurityQuestions < ActiveRecord::Migration
  def change
    create_table :security_questions do |t|
      t.text :content, null: false

      t.timestamps
    end

    add_index :security_questions, :content, unique: true
  end
end
