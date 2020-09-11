class Booking < ApplicationRecord
  validates :status, inclusion: { in: ["Pending", "Accepted", "Declined", "Cancelled"] }
  has_many :reviews, dependent: :destroy
  belongs_to :user
  belongs_to :garment
end
