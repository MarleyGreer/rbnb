class RemoveReviewIdFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :review_id, :bigint
  end
end
