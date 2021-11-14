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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to validate_presence_of(:sender) }
  it { is_expected.to validate_presence_of(:receiver) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to belong_to(:sender) }
  it { is_expected.to belong_to(:receiver) }

  it "has a valid factory" do
    sender = FactoryBot.create(:account)
    transaction = FactoryBot.create(:transaction, sender: sender, amount: 10.0)
    sender.reload
    expect(transaction).to be_valid
    expect(sender.balance.to_f).to eq(90.0)
    expect(transaction.receiver.balance.to_f).to eq(110.0)
  end

  it "sender has not enough balance" do
    transaction = FactoryBot.build(:transaction, amount: 1000.0)
    expect(transaction.save).to be false
  end

  it "amount not accept negative" do
    transaction = FactoryBot.build(:transaction, amount: -1000.0)
    expect(transaction.save).to be false
  end

  it "sender not verifid account" do
    unverified_sender = FactoryBot.create(:account, status: 'unverified')
    wrong_transaction = FactoryBot.build(:transaction, sender: unverified_sender, amount: 10.0)
    expect(wrong_transaction.save).to be false
  end
end
