class SetDefaultScoreToResults < ActiveRecord::Migration[5.2]
  def change
    change_column :results, :score, :integer, default: 0
  end
end
