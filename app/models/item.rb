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
end
