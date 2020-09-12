class GarmentsController < ApplicationController
  before_action :set_garment, only: [:show, :edit, :update, :destroy]

  def home
  end

  def index
    if params[:category]
      garments = Garment.where(category = params[:category])
    else
    @garments = Garment.all
    end
  end

  def show
    @garment = Garment.find(params[:id])
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
