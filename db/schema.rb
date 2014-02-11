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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140211045922) do

  create_table "crimes", :force => true do |t|
    t.string "fromdate"
    t.string "todate"
    t.string "weapontype"
    t.string "buildingtype"
    t.string "placeofentry"
    t.string "suspecttransportation"
    t.string "victimactivity"
    t.string "unusualactions"
    t.string "weather"
    t.string "neighborhood"
    t.string "lighting"
    t.string "domestic"
    t.string "weapon_type"
    t.string "day_week"
    t.string "computedcrimecodedesc"
    t.string "streetname"
    t.string "xstreetname"
  end

end
