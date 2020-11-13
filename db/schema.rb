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

ActiveRecord::Schema.define(version: 2020_10_28_180710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "user_id"
    t.integer "pay_type"
    t.float "basic_pay"
    t.float "overtime_price"
    t.float "holiday_price"
    t.float "midnight_price"
    t.integer "commutation_type"
    t.float "commutation_tax"
    t.float "commutation_nontax"
    t.float "allowance_1"
    t.float "allowance_2"
    t.float "allowance_3"
    t.float "allowance_4"
    t.float "allowance_5"
    t.integer "scheduled_hours_h"
    t.integer "scheduled_hours_m"
    t.float "workday"
    t.float "paid_holiday"
    t.float "leave_deduction"
    t.integer "normal_hours_h"
    t.integer "normal_hours_m"
    t.integer "overtime_hours_h"
    t.integer "overtime_hours_m"
    t.integer "holiday_hours_h"
    t.integer "holiday_hours_m"
    t.integer "midnight_hours_h"
    t.integer "midnight_hours_m"
    t.integer "late_early_h"
    t.integer "late_early_m"
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_members_on_unlock_token", unique: true
  end

  create_table "payrolls", force: :cascade do |t|
    t.string "user_name"
    t.string "member_name"
    t.string "pay_day"
    t.string "workday"
    t.string "paid_holiday"
    t.string "leave_deduction"
    t.string "normal_hours"
    t.string "overtime_hours"
    t.string "holiday_hours"
    t.string "midnight_hours"
    t.string "late_early"
    t.string "allowance_name_1"
    t.string "allowance_name_2"
    t.string "allowance_name_3"
    t.string "allowance_name_4"
    t.string "allowance_name_5"
    t.integer "basic_salary"
    t.integer "overtime_allowance"
    t.integer "holiday_allowance"
    t.integer "midnight_allowance"
    t.integer "commutation_allowance_tax"
    t.integer "commutation_allowance_nontax"
    t.integer "allowance_1"
    t.integer "allowance_2"
    t.integer "allowance_3"
    t.integer "allowance_4"
    t.integer "allowance_5"
    t.integer "user_id"
    t.integer "member_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "availability"
    t.integer "paid_holiday_allowance"
    t.integer "leave_deduction_price"
    t.integer "late_early_price"
    t.string "stating_day"
    t.string "closing_day"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "closing_date"
    t.integer "payday"
    t.float "basic_daily"
    t.string "allowance_1"
    t.string "allowance_2"
    t.string "allowance_3"
    t.string "allowance_4"
    t.string "allowance_5"
    t.integer "pay_year"
    t.integer "pay_month"
    t.integer "paymonth"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
