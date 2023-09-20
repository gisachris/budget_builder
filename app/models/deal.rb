class Deal < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_deals, dependent: :destroy
  has_many :categories, through: :category_deals
  accepts_nested_attributes_for :category_deals

  validates :name, presence: true
  validates :amount, numericality: { only_integer: true }
end
