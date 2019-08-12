class AddColumnToAnswerResults < ActiveRecord::Migration[5.2]
  def change
    add_column :result_answers, :deleted_at, :datetime
    add_index :result_answers, :deleted_at
  end
end
