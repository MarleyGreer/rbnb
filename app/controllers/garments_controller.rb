class GarmentsController < ApplicationController
  before_action :set_garment, only: [:show, :edit, :update, :destroy]

  def home
  end

  def index
    @garments = Garment.where.not(latitude: nil, longitude: nil)
    @markers = @garments.geocoded.map do |garment|
      {
        lat: garment.latitude,
        lng: garment.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { garment: garment }),
        image_url: helpers.asset_url('dress-icon.png')
      }
    end

    @garments = Garment.all
    @sizeselection = {prompt: true}
    @categoryselection = {prompt: true}
    @colourselection = {prompt: true}
    if params[:pricequery].nil?
      @priceselection = 0
      pricing_options
    else
      @garments = @garments.where(price: 0..25) if params[:pricequery] == "1"
      @garments = @garments.where(price: 26..50) if params[:pricequery] == "2"
      @garments = @garments.where(price: 51..75) if params[:pricequery] == "3"
      @garments = @garments.where(price: 76..100) if params[:pricequery] == "4"
      @garments = @garments.where(price: 101..150) if params[:pricequery] == "5"
      @garments = @garments.where(price: 151..200) if params[:pricequery] == "6"
      @garments = @garments.where("price > 200") if params[:pricequery] == "7"
      pricing_options
      @priceselection = params[:pricequery]
    end
    if params[:garment].present?
      if params[:garment][:size] != ""
        @garments = @garments.where(size: params[:garment][:size].to_i)
        @sizeselection = {selected: params[:garment][:size].to_i}
        pricing_options
      end
      if params[:garment][:colour] != ""
        @garments = @garments.where(colour: params[:garment][:colour])
        @colourselection = {selected: params[:garment][:colour]}
        pricing_options
      end
      if params[:garment][:category] != ""
        @garments = @garments.where(category: params[:garment][:category])
        @categoryselection = {selected: params[:garment][:category]}
        pricing_options
      end
    end
  end


  def all
    @garments = Garment.where(user: current_user)
  end

  def show
    @booking = Booking.new
    @garment = Garment.find(params[:id])
    @bookings = @garment.bookings
    if @garment.user == current_user
      @userowner = true
    else
      @userowner = false
    end
    @reviews = []
    @bookings.map do |booking|
      booking.reviews.map do |review|
        if review.present?
        @reviews << review

        end
      end
    end

    @sum = 0
    @reviews.each do |review|
      @sum = @sum += review.rating
      if @sum == 0
      @average = 0
      else @average = @sum / @reviews.count
      end
    end
  end


  def new
    @garment = Garment.new
  end

  def edit
  end

  def update
    @garment.update(garment_params)
    redirect_to garment_path(@garment)
  end

  def create
    @garment = Garment.new(garment_params)
    @garment.user = current_user
    if @garment.save
      redirect_to garment_path(@garment)
    else
      render :new
    end
  end

  def destroy
    @garment.destroy
    redirect_to garments_path
  end


  private

  def set_garment
    @garment = Garment.find(params[:id])

  end

  def garment_params
    params.require(:garment).permit(:name, :description, :price, :category, :size, :colour, :address, photos: [])
  end

  def pricing_options
    @priceoptions = [["Please Select"]]
    @priceoptions << ["Under $25",1] if @garments.where(price: 0..25).count > 0
    @priceoptions << ["$26-$50",2] if @garments.where(price: 26..50).count > 0
    @priceoptions << ["$51-$75",3] if @garments.where(price: 51..75).count > 0
    @priceoptions << ["$76-$100",4] if @garments.where(price: 76..100).count > 0
    @priceoptions << ["$100-$150",5] if @garments.where(price: 101..150).count > 0
    @priceoptions << ["$151-$200",6] if @garments.where(price: 151..200).count > 0
    @priceoptions << ["$200+", 7] if @garments.where("price > 200").count > 0
  end
end
