class CreateResultAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :result_answers do |t|
      t.integer :answer_id
      t.integer :result_id

      t.timestamps
    end

    add_index :result_answers, [:answer_id, :result_id]
  end
end
