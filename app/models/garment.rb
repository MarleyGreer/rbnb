class Garment < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category, presence: true, inclusion: { in: ["Dress", "Top", "Knitwear", "Skirt", "Pant", "Jacket", "Denim", "Shoes", "Accessories"] }
  validates :size, presence: true, inclusion: { in: [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] }
  validates :colour, presence: true
  validates :address, presence: true
  belongs_to :user
  has_many_attached :photos
end
