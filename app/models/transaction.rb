# == Schema Information
#
# Table name: transactions
#
#  id          :bigint           not null, primary key
#  amount      :decimal(8, 2)    default(0.0)
#  currency    :string           default("AED")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint
#  sender_id   :bigint
#
# Indexes
#
#  index_transactions_on_receiver_id  (receiver_id)
#  index_transactions_on_sender_id    (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => accounts.id)
#  fk_rails_...  (sender_id => accounts.id)
#
class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'Account', foreign_key: 'receiver_id'

  validates :sender, :receiver, :currency, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.0 }

  validate :check_valid_amount
  validate :check_valid_accounts

  after_save :transfer_money

  def transfer_money
    begin
      ActiveRecord::Base.transaction do
        self.sender.withdrawal(self.amount)
        self.receiver.deposit(self.amount)
      end
    rescue
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def check_valid_amount
    if self.sender.balance < self.amount
      self.errors.add(:sender, "hasn't enough balance to transfer money")
    end
  end

  def check_valid_accounts
    if !self.sender.is_verified?
      self.errors.add(:sender, "not verified account to transfer money")
    end

    if !self.receiver.is_verified?
      self.errors.add(:receiver, "not verified account to receive money")
    end

    if self.sender_id == self.receiver_id
      self.errors.add(:receiver, "should not be same account of sender")
    end
  end
end
