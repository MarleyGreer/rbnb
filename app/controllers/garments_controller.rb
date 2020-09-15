class GarmentsController < ApplicationController
  before_action :set_garment, only: [:show, :edit, :update, :destroy]

  def home
  end

  def index


    @garments = Garment.where(nil) # creates an anonymous scope
    @garments = @garments.filter_by_category(params[:category]) if params[:category].present?
    @garments = @garments.filter_by_price(params[:price]) if params[:price].present?
    @garments = @garments.filter_by_size(params[:size]) if params[:size].present?

    #   @markers = @garments.geocoded.map do |garment|
    #   {
    #     lat: garment.latitude,
    #     lng: garment.longitude
    #   }
    # end

  end

  def all
    @garments = Garment.where(user: current_user)
  end

  def show
    @garment = Garment.find(params[:id])
    if @garment.user == current_user
      @userowner = true
    else
      @userowner = false
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
end
