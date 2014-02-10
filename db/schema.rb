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

ActiveRecord::Schema.define(:version => 20140210061427) do

  create_table "crime", :force => true do |t|
    t.string "FROMDATE"
    t.string "TODATE"
    t.string "WEAPONTYPE"
    t.string "BUILDINGTYPE"
    t.string "PLACEOFENTRY"
    t.string "SUSPECTTRANSPORTATION"
    t.string "VICTIMACTIVITY"
    t.string "UNUSUALACTIONS"
    t.string "WEATHER"
    t.string "NEIGHBORHOOD"
    t.string "LIGHTING"
    t.string "DOMESTIC"
    t.string "WEAPOND_TYPE"
    t.string "DAY_WEEK"
    t.string "COMPUTEDCRIMECODEDESC"
    t.string "STREETNAME"
    t.string "XSTREETNAME"
  end

end
