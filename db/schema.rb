# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_05_193014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_tokens", force: :cascade do |t|
    t.integer "kind", default: 0
    t.bigint "user_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_action_tokens_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "affiliations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "alert_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "is_editable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.bigint "alert_category_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_category_id"], name: "index_alerts_on_alert_category_id"
  end

  create_table "app_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "kind"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "push_token"
    t.index ["user_id"], name: "index_app_tokens_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.string "number"
    t.string "title"
    t.text "summary"
    t.string "full_text_url"
    t.date "introduced_on"
    t.date "house_voted_on"
    t.date "senate_voted_on"
    t.date "enacted_on"
    t.date "vetoed_on"
    t.datetime "deep_scraped_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "breakdown"
    t.text "digging_deeper"
    t.integer "feature_state", default: 0
    t.integer "feature_position", default: 0
    t.string "house_result"
    t.string "senate_result"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
    t.text "for_left"
    t.text "for_right"
    t.string "slug"
    t.bigint "topic_id"
    t.boolean "is_visible", default: true
    t.bigint "congress_id"
    t.index ["congress_id"], name: "index_bills_on_congress_id"
    t.index ["topic_id"], name: "index_bills_on_topic_id"
  end

  create_table "bills_committees", id: false, force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "committee_id", null: false
    t.index ["bill_id", "committee_id"], name: "index_bills_committees_on_bill_id_and_committee_id"
    t.index ["committee_id", "bill_id"], name: "index_bills_committees_on_committee_id_and_bill_id"
  end

  create_table "bills_posts", id: false, force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "post_id", null: false
  end

  create_table "bills_tags", id: false, force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "tag_id", null: false
    t.index ["bill_id", "tag_id"], name: "index_bills_tags_on_bill_id_and_tag_id"
    t.index ["tag_id", "bill_id"], name: "index_bills_tags_on_tag_id_and_bill_id"
  end

  create_table "chambers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chambers_committees", id: false, force: :cascade do |t|
    t.bigint "chamber_id", null: false
    t.bigint "committee_id", null: false
  end

  create_table "committee_memberships", force: :cascade do |t|
    t.bigint "committee_id"
    t.bigint "member_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["committee_id"], name: "index_committee_memberships_on_committee_id"
    t.index ["member_id"], name: "index_committee_memberships_on_member_id"
  end

  create_table "committees", force: :cascade do |t|
    t.string "name"
    t.string "bioguide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "congresses", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "favoritable_id"
    t.string "favoritable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritable_id", "favoritable_type"], name: "index_favorites_on_favoritable_id_and_favoritable_type"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media_videos", force: :cascade do |t|
    t.bigint "member_id"
    t.string "name"
    t.string "youtube_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_visible", default: true
    t.index ["member_id"], name: "index_media_videos_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "state_id"
    t.string "name"
    t.string "title"
    t.string "short_title"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "suffix"
    t.date "date_of_birth"
    t.string "party"
    t.string "leadership_role"
    t.string "url"
    t.string "office_address"
    t.string "phone"
    t.string "fax"
    t.string "bioguide_id"
    t.integer "gender"
    t.string "twitter"
    t.string "facebook"
    t.string "youtube"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.bigint "chamber_id"
    t.string "slug"
    t.boolean "in_office", default: true
    t.datetime "facebook_photo_scraped_at"
    t.boolean "facebook_photo_scrape_status"
    t.text "bio"
    t.index ["chamber_id"], name: "index_members_on_chamber_id"
    t.index ["state_id"], name: "index_members_on_state_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "kind"
    t.bigint "user_id"
    t.boolean "is_read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "bill_id"
    t.bigint "user_id"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_positions_on_bill_id"
    t.index ["user_id"], name: "index_positions_on_user_id"
  end

  create_table "post_positions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_positions_on_post_id"
    t.index ["user_id"], name: "index_post_positions_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "state", default: 0
    t.datetime "publish_at"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
    t.string "source"
    t.string "url"
    t.string "title"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "topic_id"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsorships", force: :cascade do |t|
    t.bigint "bill_id"
    t.bigint "member_id"
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_sponsorships_on_bill_id"
    t.index ["member_id"], name: "index_sponsorships_on_member_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "excluded_alert_category_ids", default: [], array: true
    t.datetime "dashboards_show_intro"
    t.datetime "bills_show_intro"
    t.datetime "members_index_intro"
    t.integer "birth_year"
    t.bigint "race_id"
    t.bigint "gender_id"
    t.bigint "affiliation_id"
    t.boolean "voted_in_2016"
    t.string "provider"
    t.string "uid"
    t.integer "role", default: 0
    t.integer "visits_count", default: 0, null: false
    t.index ["affiliation_id"], name: "index_users_on_affiliation_id"
    t.index ["gender_id"], name: "index_users_on_gender_id"
    t.index ["race_id"], name: "index_users_on_race_id"
    t.index ["state_id"], name: "index_users_on_state_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "chamber_id"
    t.bigint "bill_id"
    t.bigint "member_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_votes_on_bill_id"
    t.index ["chamber_id"], name: "index_votes_on_chamber_id"
    t.index ["member_id"], name: "index_votes_on_member_id"
  end

  add_foreign_key "action_tokens", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alerts", "alert_categories"
  add_foreign_key "app_tokens", "users"
  add_foreign_key "bills", "congresses"
  add_foreign_key "bills", "topics"
  add_foreign_key "committee_memberships", "committees"
  add_foreign_key "committee_memberships", "members"
  add_foreign_key "favorites", "users"
  add_foreign_key "media_videos", "members"
  add_foreign_key "members", "states"
  add_foreign_key "notifications", "users"
  add_foreign_key "positions", "bills"
  add_foreign_key "positions", "users"
  add_foreign_key "post_positions", "posts"
  add_foreign_key "post_positions", "users"
  add_foreign_key "posts", "topics"
  add_foreign_key "sponsorships", "bills"
  add_foreign_key "sponsorships", "members"
  add_foreign_key "users", "states"
  add_foreign_key "votes", "bills"
  add_foreign_key "votes", "chambers"
  add_foreign_key "votes", "members"
end
