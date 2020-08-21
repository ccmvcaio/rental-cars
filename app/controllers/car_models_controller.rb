class CarModelsController < ApplicationController
  before_action :set_car_model, only: [:show]
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  
  def index
    @car_models = CarModel.all
  end

  def show
  end

  def new
    @car_model = CarModel.new
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    if @car_model.save
      redirect_to @car_model
    else
      @car_categories = CarCategory.all
      render :new
    end
  end
  
  private

  def car_model_params
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type,
                                      :car_category_id, :manufacturer)
  end

  def set_car_model
    @car_model = CarModel.find(params[:id])
  end
end