class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :garment
  has_many :reviews, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: ["pending", "confirmed", "declined", "cancelled"] }
  validate :end_date_after_start_date

  scope :filter_by_status, -> (status) { where status: status }
  scope :filter_by_garment, -> (garment) { where garment: garment }

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
