class GarmentsController < ApplicationController
  before_action :set_garment, only: [:show, :edit, :update, :destroy]

  def home
  end

  def index
    @garments = Garment.all
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
    if @garment.save
      redirect_to garment_path(@garment)
    else
      render :new
    end
  end

  def destroy
    @garment.destroy
  end

  private

  def set_garment
    @garment = Garment.find(params[:id])
  end

  def garment_params
    params.require(:garment).permit(:name, :description, :price, :category, :size, :colour, :photo, :address)
  end
end
