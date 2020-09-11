class BookingsController < ApplicationController
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
    @booking.user = current_user
    @booking.garment = @garment
    if @booking.save
      redirect_to garment_path(@garment)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def accept
  end

  def decline
  end

  def cancel
  end

  def booking_params
    params.require(:booking).permit(:start_date, :expires_at)
  end
end
