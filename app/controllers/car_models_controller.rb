class CarModelsController < ApplicationController
  before_action :set_car_model, only: [:show]
  
  def index
    @car_models = CarModel.all
  end

  def show
  end

  private

  def set_car_model
    @car_model = CarModel.find(params[:id])
  end
end