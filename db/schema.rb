# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180124105128) do

  create_table "carts", force: :cascade do |t|
    t.string   "items"
    t.integer  "customer_id"
    t.integer  "numberofitems"
    t.string   "products"
    t.float    "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type"

  create_table "compares", force: :cascade do |t|
    t.integer  "number"
    t.integer  "opt1"
    t.integer  "opt2"
    t.integer  "opt3"
    t.integer  "opt4"
    t.integer  "opt5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "city"
    t.string   "street"
    t.integer  "zip"
    t.integer  "costmodel"
    t.string   "favorites"
    t.string   "workcity"
    t.string   "workstreet"
    t.integer  "workzip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directions", force: :cascade do |t|
    t.integer  "optimization_id"
    t.integer  "from"
    t.integer  "to"
    t.integer  "by"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "typey"
  end

  create_table "distances", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.float    "traveltime"
    t.float    "traveldistance"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "status"
    t.integer  "typey"
  end

  create_table "drivers", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "optimizations", force: :cascade do |t|
    t.integer  "optimizationtype"
    t.integer  "orders"
    t.integer  "totalboxes"
    t.integer  "totalcoolingboxes"
    t.integer  "totalfreezingboxes"
    t.string   "allocation"
    t.string   "routes"
    t.float    "totaltraveltime"
    t.float    "totaldistance"
    t.float    "turnover"
    t.float    "productcosts"
    t.float    "worktimecosts"
    t.float    "drivingcosts"
    t.float    "profit"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "emissions"
    t.integer  "stores"
    t.string   "orderslist"
    t.integer  "statustype"
    t.string   "name"
    t.float    "realtotaldistance"
  end

  create_table "options", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "allocationmethod"
    t.string   "day"
    t.string   "timewindow"
    t.string   "products"
    t.float    "neededboxes"
    t.float    "neededcoolingboxes"
    t.float    "neededfreezingboxes"
    t.integer  "allocatedstore"
    t.integer  "allocateddriver"
    t.string   "estimatedtime"
    t.integer  "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "price"
    t.integer  "optimization"
    t.string   "possiblestores"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "brand"
    t.float    "price"
    t.float    "discountprice"
    t.string   "description"
    t.float    "weight"
    t.float    "volume"
    t.boolean  "vegan"
    t.boolean  "bio"
    t.string   "picture"
    t.integer  "durability"
    t.string   "category"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "driver_id"
    t.integer  "optimization_id"
    t.string   "day"
    t.string   "route"
    t.float    "traveltime"
    t.float    "traveldistance"
    t.float    "worktimecosts"
    t.float    "drivingcosts"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "emissions"
    t.integer  "boxes"
    t.integer  "coolingboxes"
    t.integer  "freezingboxes"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "store_id"
    t.boolean  "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "street"
    t.integer  "zip"
    t.integer  "concept"
    t.string   "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.integer  "status"
    t.boolean  "driver"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vehicles", force: :cascade do |t|
    t.string   "name"
    t.float    "range"
    t.float    "emissions"
    t.float    "speed"
    t.float    "boxcapacity"
    t.float    "coolingboxcapacity"
    t.float    "freezingboxcapacity"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
