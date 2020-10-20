class Category < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :is_active, inclusion: { in: [ true, false ] }

  def self.for_select
    Category.all.map do |category|
      "#{category.name}"
    end
  end
end
