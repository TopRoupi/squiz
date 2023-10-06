class CreatePresences < ActiveRecord::Migration[7.2]
  def change
    create_table :presences, id: :uuid do |t|
      t.references :room, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
