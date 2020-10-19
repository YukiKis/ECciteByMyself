class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :tel, presence: true
  validates :is_active, inclusion: { in: [ true, false ] }

  def full_name
    self.last_name + self.first_name
  end

  def full_name_kana 
    self.last_name_kana + self.first_name_kana
  end

  def full_name_with_space
    self.last_name + " " + self.first_name
  end

  def full_name_kana_with_space
    self.last_name_kana + " " + self.first_name_kana
  end
end

