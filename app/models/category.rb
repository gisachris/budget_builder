class Category < ApplicationRecord
  has_many :category_deals
  has_many :deals, through: :category_deals

  validates :name, presence: true
  validates :icon, presence: true
end
