class CreatePicks < ActiveRecord::Migration[7.2]
  def change
    create_table :picks, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :choice, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
