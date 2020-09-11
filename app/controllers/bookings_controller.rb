class BookingsController < ApplicationController
    def index
      @bookings = Booking.where("user = current_user")
    end

    def show
      @booking = Booking.find(params[:booking_id])
    end

    def new
      @booking = Booking.new
      @garment = Garment.find(params[:garment_id])
    end

    def create
      @booking = Booking.new(booking_params)
      @garment = Garment.find(params[:garment_id])
      @booking.garment = @garment
        if @booking.save
          redirect_to garment_path(@garment)
        else render :new
      end
    end

    def edit
    end

    def update
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

    def booking_params
      params.require(:booking).permit(:start_date, :end_date)
    end

    def check_booking_status(status)
      @bookings = []
        Booking.all.select do |booking|
        if booking.garment.user == current_user && booking.status == status
          @bookings << booking
        end
      end
    end
end
