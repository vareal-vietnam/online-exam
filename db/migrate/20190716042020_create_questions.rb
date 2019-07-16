class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :test_id

      t.timestamps
    end

    add_index :questions, :test_id
  end
end
