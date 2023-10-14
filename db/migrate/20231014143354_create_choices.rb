class CreateChoices < ActiveRecord::Migration[7.2]
  def change
    create_table :choices, id: :uuid do |t|
      t.references :track, null: false, foreign_key: true, type: :uuid
      t.string :spotify_track_id
      t.string :album_name
      t.string :album_image_url
      t.string :artist_name
      t.string :preview_url
      t.string :name
      t.boolean :decoy, default: false

      t.timestamps
    end
  end
end
