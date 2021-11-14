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
  belongs_to :sender
  belongs_to :receiver
end
