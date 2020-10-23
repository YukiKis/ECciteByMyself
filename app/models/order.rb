class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum how_to_pay: {"クレジットカード": 0, "銀行振込": 1}
  enum status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }

  validates :deliver_postcode, presence: true
  validates :deliver_address, presence: true
  validates :deliver_name, presence: true
  validates :deliver_fee, presence: true, numericality: true
  validates :total_price, presence: true, numericality: true
  validates :how_to_pay, presence: true, inclusion: { in: ["クレジットカード", "銀行振込"] }
  validates :status, presence: true, inclusion: {in: ["入金待ち", "入金確認", "製作中", "発送準備中", "発送済み"] }

  scope :today, ->(){ where("created_at >= ?", Date.today) }

  def set_order_items(customer)
    customer = Customer.find(customer.id)
    customer.cart_items.each do |item|
      order_item = self.order_items.new(item: item.item)
      order_item.amount = item.amount
      order_item.price = item.price
      order_item.save
    end
  end

  def set_total_price
    total_price = 0
    self.order_items.each do |item|
      total_price += item.subtotal
    end
    self.total_price = total_price
  end

  def get_whole_total_price
    self.total_price + self.deliver_fee
  end

  def deliver_show
    "#{ self.deliver_postcode} #{self.deliver_address } #{ self.deliver_name}"
  end
  
  def date_show
    "#{ self.created_at.strftime("%Y/%m/%d %H:%M:%S") }"
  end

  def item_count 
    count = 0
    self.order_items.each do |order_item|
      count += order_item.amount 
    end
    count
  end
end
