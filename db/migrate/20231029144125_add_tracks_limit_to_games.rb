class AddTracksLimitToGames < ActiveRecord::Migration[7.2]
  def up
    add_column :games, :tracks_limit, :integer
    Game.update_all(tracks_limit: 5)
    change_column :games, :tracks_limit, :integer, null: false, default: 5
  end

  def down
    remove_column :games, :tracks_limit
  end
end
