class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games, id: :uuid do |t|
      t.references :room, null: false, foreign_key: true, type: :uuid
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
