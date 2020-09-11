class BookingsController < ApplicationController
before_action :set_booking, only: [:show, :edit, :update, :accept, :decline, :cancel]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @garment = Garment.find(params[:garment_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @garment = Garment.find(params[:garment_id])
    @booking.total_price = (params["booking"]["end_date"].to_datetime - params["booking"]["start_date"].to_datetime) * @garment.price
    @booking.status = "Pending"
    @booking.garment = @garment
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  def accept
  end

  def decline
  end

  def cancel
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
