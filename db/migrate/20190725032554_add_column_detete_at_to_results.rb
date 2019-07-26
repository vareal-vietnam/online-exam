class AddColumnDeteteAtToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :deleted_at, :datetime
    add_index :results, :deleted_at
  end
end
