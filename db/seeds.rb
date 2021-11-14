# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Account.count.zero?
  Account.create([{first_name: "Mohamed",
 last_name: "Mohamed",
 phone_number: "+9715252525252",
 email: "mohamed_pay@mailinator.com",
 status: "verified",
 balance: 100.0,
 currency: "AED", password: "test1234"},
 {first_name: "Ahmed",
last_name: "Ahmed",
phone_number: "+9715353535353",
email: "ahmad_pay@mailinator.com",
status: "verified",
balance: 100.0,
currency: "AED", password: "test1234"},
{first_name: "Hassan",
last_name: "Hassan",
phone_number: "+9715454545454",
email: "hassan_pay@mailinator.com",
status: "verified",
balance: 100.0,
currency: "AED", password: "test1234"}])
end
