class Garment < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category, presence: true, inclusion: { in: ["Dress", "Top", "Knitwear", "Skirt", "Pant", "Jacket", "Denim", "Shoes", "Accessories"] }
  validates :size, presence: true, inclusion: { in: [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] }
  validates :colour, presence: true
  validates :address, presence: true
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many_attached :photos, dependent: :destroy
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  scope :filter_by_category, -> (category) { where category: category }
  scope :filter_by_price, -> (price) { where price: price }


end
