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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100929143953) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "telephone"
    t.string   "url"
    t.string   "btw_nr"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connections", :force => true do |t|
    t.integer  "left_interface_id",  :null => false
    t.integer  "right_interface_id", :null => false
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datacenters", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.integer  "company_id"
    t.string   "type"
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interfaces", :force => true do |t|
    t.integer  "device_id",  :null => false
    t.string   "type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_racks", :force => true do |t|
    t.integer  "datacenter_id", :null => false
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.integer  "server_rack_id", :null => false
    t.integer  "number"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
