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
  end

  def create
    @garment = Garment.new(garment_params)
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
    params.require(:garment).permit()
  end
end
