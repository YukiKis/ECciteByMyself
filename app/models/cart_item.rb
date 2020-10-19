class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true, numericality: true

  def price_with_tax
    (self.item.price * 1.1).floor
  end

  def self.total_price_with_tax(customer)
    total_price = 0
    customer.cart_items.each do |cart_item|
      total_price +=cart_item.subtotal
    end
    total_price
  end

  def subtotal
    self.price_with_tax * self.amount
  end
end
