class Deal < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :category_deals
  has_many :categories, through: :category_deals

  validates :name, presence: true
  validates :amount, numericality: { only_integer: true }
end
