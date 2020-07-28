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

ActiveRecord::Schema.define(version: 2020_07_28_223248) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "slug", null: false
    t.text "description", null: false
    t.string "title"
    t.string "long_title", default: "", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "color_scales", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.string "category_one"
    t.string "category_two"
    t.string "category_three"
    t.boolean "inverted", default: true, null: false
    t.index ["minimum", "maximum"], name: "index_color_scales_on_minimum_and_maximum"
  end

  create_table "genders", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "description", null: false
    t.index ["description"], name: "index_genders_on_description", unique: true
  end

  create_table "indicators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.string "description", null: false
    t.string "tooltip"
  end

  create_table "kpis_mobility_percentages", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.float "percentage", null: false
    t.bigint "gender_id", null: false
    t.bigint "region_id", null: false
    t.bigint "category_id", null: false
    t.bigint "quintile_id", null: false
    t.index ["category_id"], name: "index_kpis_mobility_percentages_on_category_id"
    t.index ["gender_id"], name: "index_kpis_mobility_percentages_on_gender_id"
    t.index ["quintile_id"], name: "index_kpis_mobility_percentages_on_quintile_id"
    t.index ["region_id"], name: "index_kpis_mobility_percentages_on_region_id"
  end

  create_table "quintiles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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

  create_table "regions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "description", null: false
    t.string "color"
    t.index ["description"], name: "index_regions_on_description", unique: true
  end

  create_table "states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.bigint "region_id", null: false
    t.string "name"
    t.index ["region_id"], name: "index_states_on_region_id"
  end

  create_table "upward_mobilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.float "value", null: false
    t.index ["state_id"], name: "index_upward_mobilities_on_state_id"
  end

  create_table "upward_mobility_indicators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "upward_mobility_id", null: false
    t.bigint "indicator_id", null: false
    t.float "percentage", null: false
    t.index ["indicator_id"], name: "index_upward_mobility_indicators_on_indicator_id"
    t.index ["upward_mobility_id"], name: "index_upward_mobility_indicators_on_upward_mobility_id"
  end

  add_foreign_key "kpis_mobility_percentages", "categories"
  add_foreign_key "kpis_mobility_percentages", "genders"
  add_foreign_key "kpis_mobility_percentages", "quintiles"
  add_foreign_key "kpis_mobility_percentages", "regions"
  add_foreign_key "quintiles", "categories"
  add_foreign_key "quintiles", "color_scales"
  add_foreign_key "states", "regions"
  add_foreign_key "upward_mobilities", "states"
  add_foreign_key "upward_mobility_indicators", "indicators"
  add_foreign_key "upward_mobility_indicators", "upward_mobilities"
end
