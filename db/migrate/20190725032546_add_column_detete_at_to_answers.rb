class AddColumnDeteteAtToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :deleted_at, :datetime
    add_index :answers, :deleted_at
  end
end
