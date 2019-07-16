class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :is_correct
      t.integer :question_id

      t.timestamps
    end

    add_index :answers, :question_id
  end
end
