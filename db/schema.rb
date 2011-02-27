# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110227041258) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.integer  "debt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boxes", :force => true do |t|
    t.string   "box_code"
    t.string   "description"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "debts", :force => true do |t|
    t.string   "debtor"
    t.decimal  "total_amount"
    t.decimal  "balance"
    t.integer  "jewelry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "payment_date"
    t.string   "currency"
  end

  create_table "expenses", :force => true do |t|
    t.string   "concept"
    t.integer  "jewelry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "payment_date"
    t.decimal  "bob"
    t.decimal  "usd"
  end

  create_table "incomes", :force => true do |t|
    t.string   "concept"
    t.integer  "payment_id"
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "payment_date"
    t.integer  "jewelry_id"
    t.decimal  "bs"
    t.decimal  "usd"
  end

  create_table "jewelries", :force => true do |t|
    t.string   "jewelry_code"
    t.float    "weight"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.date     "purchase_date"
    t.string   "status"
    t.integer  "box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_auto_code"
    t.string   "measurement_unit"
    t.decimal  "amount"
    t.string   "currency"
  end

  create_table "payments", :force => true do |t|
    t.decimal  "amount"
    t.date     "payment_date"
    t.integer  "debt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
  end

  create_table "phone_numbers", :force => true do |t|
    t.string   "number"
    t.integer  "debt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "product_auto_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.integer  "jewelry_id"
    t.date     "date_of_sale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount"
    t.string   "currency"
  end

end
