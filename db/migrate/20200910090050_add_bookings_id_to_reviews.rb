class AddBookingsIdToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :booking_id, :bigint
  end
end
