# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_13_192257) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.string "description", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "color_scales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.boolean "positive", default: true, null: false
    t.index ["minimum", "maximum", "positive"], name: "index_color_scales_on_minimum_and_maximum_and_positive", unique: true
  end

  create_table "genders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.index ["description"], name: "index_genders_on_description", unique: true
  end

  create_table "quintiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.bigint "category_id", null: false
    t.bigint "color_scale_id", null: false
    t.index ["category_id"], name: "index_quintiles_on_category_id"
    t.index ["color_scale_id"], name: "index_quintiles_on_color_scale_id"
    t.index ["name", "category_id"], name: "index_quintiles_on_name_and_category_id", unique: true
    t.index ["slug"], name: "index_quintiles_on_slug", unique: true
  end

  create_table "regions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.index ["description"], name: "index_regions_on_description", unique: true
  end

  add_foreign_key "quintiles", "categories"
  add_foreign_key "quintiles", "color_scales"
end
