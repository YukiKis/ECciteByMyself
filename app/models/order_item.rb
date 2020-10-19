class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum status: { "着手不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3 }

  validates :price, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  validates :status, presence: true, inclusion: { in: ["着手不可", "製作待ち", "製作中", "製作完了"] }

  def subtotal
    self.item.price * self.amount
  end
end
