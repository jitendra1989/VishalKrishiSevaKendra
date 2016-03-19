class Receipt < ActiveRecord::Base
  include HumanNumbers
  belongs_to :order, counter_cache: true
  belongs_to :user

  PAYMENT_METHODS = { 1 => 'Cash', 2 => 'Cheque', 3 => 'Credit Card', 4 => 'Debit Card', 5 => 'RTGS'}

  store :payment_info, accessors: [:cheque_number, :cheque_date, :cheque_bank, :card_number, :utr], coder: JSON

  [:order_id, :user_id].each { |n| validates n, presence: true }
  validates :amount, numericality: {less_than_or_equal_to: lambda { |r| r.order.try(:unpaid_amount).try(:round) || 0 } }
  validates :payment_method, inclusion: PAYMENT_METHODS.keys

  with_options presence: true, if: lambda { |a| a.payment_method == PAYMENT_METHODS.keys.second } do |receipt|
    [:cheque_number, :cheque_date, :cheque_bank].each { |n| receipt.validates n }
  end
  validates :card_number, presence: true, if: lambda { |a| [PAYMENT_METHODS.keys.third, PAYMENT_METHODS.keys.fourth].include? a.payment_method }
end
