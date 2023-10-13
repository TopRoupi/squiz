# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2023_10_13_155024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "room_id", null: false
    t.boolean "finished", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_games_on_room_id"
  end

  create_table "presences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "room_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_presences_on_room_id"
    t.index ["user_id"], name: "index_presences_on_user_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id", null: false
    t.integer "max_users", null: false
    t.string "invite_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_rooms_on_owner_id"
  end

  create_table "tracks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_id", null: false
    t.uuid "user_id", null: false
    t.string "track_id"
    t.boolean "guessed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_tracks_on_game_id"
    t.index ["user_id"], name: "index_tracks_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "rooms"
  add_foreign_key "presences", "rooms"
  add_foreign_key "presences", "users"
  add_foreign_key "rooms", "users", column: "owner_id"
  add_foreign_key "tracks", "games"
  add_foreign_key "tracks", "users"
end
