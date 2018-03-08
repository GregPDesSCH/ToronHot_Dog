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

ActiveRecord::Schema.define(version: 8) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_condiments", force: :cascade do |t|
    t.bigint "hot_dog_stands_id"
    t.bigint "condiment_id"
    t.index ["condiment_id"], name: "index_available_condiments_on_condiment_id"
    t.index ["hot_dog_stands_id"], name: "index_available_condiments_on_hot_dog_stands_id"
  end

  create_table "condiments", force: :cascade do |t|
    t.string "nameOfCondiment"
  end

  create_table "drink_prices", force: :cascade do |t|
    t.bigint "hot_dog_stands_id"
    t.bigint "drink_id"
    t.decimal "price", precision: 4, scale: 2
    t.index ["drink_id"], name: "index_drink_prices_on_drink_id"
    t.index ["hot_dog_stands_id"], name: "index_drink_prices_on_hot_dog_stands_id"
  end

  create_table "drinks", force: :cascade do |t|
    t.string "drinkName"
  end

  create_table "food_prices", force: :cascade do |t|
    t.bigint "hot_dog_stands_id"
    t.bigint "food_id"
    t.decimal "price", precision: 4, scale: 2
    t.index ["food_id"], name: "index_food_prices_on_food_id"
    t.index ["hot_dog_stands_id"], name: "index_food_prices_on_hot_dog_stands_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "foodName"
  end

  create_table "hot_dog_stands", force: :cascade do |t|
    t.string "nameOfStand"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "customerRating"
    t.text "additionalOptions"
    t.string "actualAddress"
  end

end
