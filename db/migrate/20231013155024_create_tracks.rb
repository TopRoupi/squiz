class CreateTracks < ActiveRecord::Migration[7.2]
  def change
    create_table :tracks, id: :uuid do |t|
      t.references :game, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :track_id
      t.boolean :guessed, default: false

      t.timestamps
    end
  end
end
