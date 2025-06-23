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

ActiveRecord::Schema[7.2].define(version: 2025_06_23_182930) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.bigint "town_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description", null: false
    t.bigint "community_center_site_id"
    t.index ["community_center_site_id"], name: "index_communities_on_community_center_site_id"
    t.index ["town_id"], name: "index_communities_on_town_id"
  end

  create_table "event_series", force: :cascade do |t|
    t.string "name"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "community_id", null: false
    t.bigint "site_id", null: false
    t.date "date"
    t.string "day_of_week"
    t.time "time"
    t.string "category"
    t.text "description"
    t.index ["community_id"], name: "index_event_series_on_community_id"
    t.index ["event_id"], name: "index_event_series_on_event_id"
    t.index ["site_id"], name: "index_event_series_on_site_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "category"
    t.bigint "site_id", null: false
    t.index ["community_id"], name: "index_events_on_community_id"
    t.index ["site_id"], name: "index_events_on_site_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.bigint "country_id"
    t.bigint "province_id"
    t.index ["country_id"], name: "index_locations_on_country_id"
    t.index ["province_id"], name: "index_locations_on_province_id"
  end

  create_table "provider_tags", force: :cascade do |t|
    t.bigint "provider_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id", "tag_id"], name: "index_provider_tags_on_provider_id_and_tag_id", unique: true
    t.index ["provider_id"], name: "index_provider_tags_on_provider_id"
    t.index ["tag_id"], name: "index_provider_tags_on_tag_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id", null: false
    t.bigint "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "service"
    t.text "description"
    t.index ["community_id"], name: "index_providers_on_community_id"
    t.index ["site_id"], name: "index_providers_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.bigint "town_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "description"
    t.string "street_address"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "map_link"
    t.index ["community_id"], name: "index_sites_on_community_id"
    t.index ["town_id"], name: "index_sites_on_town_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "travelers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first"
    t.string "last"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_travelers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_travelers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_travelers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_travelers_on_unlock_token", unique: true
  end

  add_foreign_key "communities", "locations", column: "town_id"
  add_foreign_key "communities", "sites", column: "community_center_site_id"
  add_foreign_key "event_series", "communities"
  add_foreign_key "event_series", "events"
  add_foreign_key "event_series", "sites"
  add_foreign_key "events", "communities"
  add_foreign_key "events", "sites"
  add_foreign_key "locations", "locations", column: "country_id"
  add_foreign_key "locations", "locations", column: "province_id"
  add_foreign_key "provider_tags", "providers"
  add_foreign_key "provider_tags", "tags"
  add_foreign_key "providers", "communities"
  add_foreign_key "providers", "sites"
  add_foreign_key "sites", "communities"
  add_foreign_key "sites", "locations", column: "town_id"
end
