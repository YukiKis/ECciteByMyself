class Item < ApplicationRecord

  attachment :image

  belongs_to :category
  has_many :cart_items
  has_many :order_items
  validates :name, presence: true
  validates :image_id, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  validates :is_active, inclusion: { in: [true, false] }

  scope :by_name, ->(keyword){ where("name LIKE ?", "%#{keyword}%") }

  def price_with_tax
    (self.price * 1.1).floor
  end

  def status
    if is_active
     "販売中"
    else
      "販売中止"
    end
  end
end
