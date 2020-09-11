class BookingsController < ApplicationController
before_action :set_booking, only: [:show, :edit, :update, :accept, :decline, :cancel]
  
  def index
    @bookings = Booking.where("user = current_user")
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
    @booking.status = "pending"
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
  
  def confirm
    @booking = Booking.find(params[:id])
    @booking.status = "confirmed"
    @booking.save
    redirect_to confirmed_bookings_path
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.status = "declined"
    @booking.save
    redirect_to declined_bookings_path
  end

  def cancel
    @booking = Booking.find(params[:id])
    @booking.status = "cancelled"
    @booking.save
    redirect_to cancelled_bookings_path
  end

  def all
    @bookings = []
      Booking.all.select do |booking|
      if booking.garment.user == current_user
        @bookings << booking
      end
    end
  end

  def confirmed
    check_booking_status("confirmed")
  end

  def pending
    check_booking_status("pending")
  end

  def cancelled
   check_booking_status("cancelled")
  end

  def declined
    check_booking_status("declined")
  end

  def check_booking_status(status)
    @bookings = []
      Booking.all.select do |booking|
      if booking.garment.user == current_user && booking.status == status
        @bookings << booking
      end
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
