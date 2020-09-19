class BookingsController < ApplicationController
before_action :set_booking, only: [:show, :edit, :update, :confirm, :decline, :cancel]

  def index
    @bookings = Booking.where(user: current_user)
    @bookingselect = {prompt: true}
    if params[:booking].present?
      @bookings = @bookings.where(status: params[:booking][:status])
      @bookingselect = {selected: params[:booking][:status]}
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @garment = @booking.garment
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
      redirect_to new_user_session_path
    end
  end

  def edit
    garment_id = @booking.garment_id
    @garment = Garment.find(garment_id)
  end

  def update
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  def confirm
    @booking.status = "confirmed"
    @booking.save
    redirect_to confirmed_bookings_path
  end

  def decline
    @booking.status = "declined"
    @booking.save
    redirect_to declined_bookings_path
  end

  def cancel
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
