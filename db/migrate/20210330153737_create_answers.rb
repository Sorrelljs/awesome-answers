class CreateAnswers < ActiveRecord::Migration[6.1]
# This file was generated with:
# rails g model answer body:text question:references 
# 
  def change
    create_table :answers do |t|
      t.text :body

      # This creates a "question_id" column of type "big_int"
      # It also sets a foreign_key constraint to enforce the 
      # association to the questions table at the database level.
      # The "question_id" field will refer to the primary key of 
      # that the answer "belongs_to" the question

      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
