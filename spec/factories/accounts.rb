# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                 :bigint           not null, primary key
#  auth_token         :string
#  balance            :decimal(8, 2)    default(0.0)
#  currency           :string           default("AED")
#  email              :string
#  encrypted_password :string           default("")
#  first_name         :string
#  last_name          :string
#  phone_number       :string
#  status             :integer          default("pending"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_accounts_on_email         (email)
#  index_accounts_on_phone_number  (phone_number)
#  index_accounts_on_status        (status)
#
FactoryBot.define do
  factory :account do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164[0...15] }
    password { Faker::Internet.password }
    balance { 100.0 }

    status { "verified" }
  end
end
