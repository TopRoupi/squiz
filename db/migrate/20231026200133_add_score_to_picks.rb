class AddScoreToPicks < ActiveRecord::Migration[7.2]
  def up
    add_column :picks, :score, :integer
    add_column :picks, :seconds, :integer
    Pick.update_all(score: 0)
    Pick.update_all(seconds: 0)
    change_column :picks, :score, :integer, null: false
    change_column :picks, :seconds, :integer, null: false
  end

  def down
    remove_column :picks, :score
  end
end
