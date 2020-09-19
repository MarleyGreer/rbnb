class ReviewsController < ApplicationController

def new
 @booking = Booking.find(params[:booking_id])
 @review = Review.new
end

def create
  @review = Review.new(review_params)
  @booking = Booking.find(params[:booking_id])
  @review.booking = @booking
  @garment = @booking.garment
  if @review.save
    redirect_to garment_path(@garment)
  else
    render :new
  end
end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end
