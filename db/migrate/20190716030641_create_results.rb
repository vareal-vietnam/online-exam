class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :score
      t.integer :user_id
      t.integer :test_id

      t.timestamps
    end

    add_index :results, [:user_id, :test_id]
  end
end
