class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms, id: :uuid do |t|
      t.references :owner, null: false, foreign_key: {to_table: "users"}, type: :uuid
      t.integer :max_users, null: false
      t.string :invite_code, null: false

      t.timestamps
    end
  end
end
