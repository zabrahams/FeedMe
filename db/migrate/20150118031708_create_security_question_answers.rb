class CreateSecurityQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :security_question_answers do |t|
      t.string :answer_digest, null: false
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end

    add_index :security_question_answers, :user_id
    add_index :security_question_answers, :question_id
    add_index :security_question_answers, [:user_id, :question_id], unique: true
  end
end
