class CreatePhaseChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :phase_changes, id: :uuid do |t|
      t.references :game, null: false, foreign_key: true, type: :uuid
      t.integer :phase, default: 0
      t.timestamp :end_time

      t.timestamps
    end
  end
end
