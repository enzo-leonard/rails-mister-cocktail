class DosesController < ApplicationController
  before_action :find_dose, only: [ :show, :destroy, :edit, :update]
  def index
  end

  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def edit
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.save!
    @cocktail = Cocktail.find(params[:cocktail_id])

    redirect_to cocktail_path(@cocktail)
  end

  def update
  end

  def destroy
    @dose.destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    redirect_to cocktail_path(@cocktail)

  end

  def show
  end

   private

  def find_dose
    @dose = Dose.find(params[:id])

  end

  def dose_params
    paramsC = {cocktail_id: params[:cocktail_id]}
    params.require(:dose).permit(:description, :ingredient_id).merge(paramsC)

  end
end
