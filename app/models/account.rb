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
class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :validatable:rememberable, :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :sent_transactions, class_name: "Transaction", foreign_key: :sender_id, dependent: :destroy
  has_many :received_transactions, class_name: "Transaction", foreign_key: :receiver_id, dependent: :destroy

  validates :first_name, :last_name, :email, :phone_number, presence: true

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "Email invalid"  },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }

  validates :phone_number, format: { with: /\A\+\d{11,14}\z/, message: "Phone format should be as +12124567890"  },
            uniqueness: { case_sensitive: false },
            length: { minimum: 11, maximum: 15 }

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  before_create :generate_authentication_token!

  # STATUSES values, and scopes filter by status, and instance methods for statuses
  enum status: {
    unverified: -1,
    pending: 0,
    verified: 1
  }, _suffix: true

  STATUSES = %w(verified unverified pending)

  scope :verified, -> { where(status: "verified") }
  scope :unverified, -> { where(status: "unverified") }
  scope :pending, -> { where(status: "pending") }

  STATUSES.each do |status_val|
    define_method("is_#{status_val}?") { self.status == status_val }
  end

  # methods related to deduct money and deposit to other accounts.
  def withdrawal amount=0.0
    self.update(balance: self.balance - amount)
  end

  def deposit amount=0.0
    self.update(balance: self.balance + amount)
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
