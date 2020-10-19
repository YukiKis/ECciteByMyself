class Delivery < ApplicationRecord
  belongs_to :customer

  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true

  def show
    "#{ self.postcode } #{ self.address } #{ self.name }"
  end

  def self.for_select(customer)
    Delivery.where(customer_id: customer.id).map do |d|
      d.show
    end
  end

end
