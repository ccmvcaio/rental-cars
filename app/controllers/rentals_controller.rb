class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :set_rental, only: [:show]

  def index
    @rentals = Rental.all
  end
  
  def show
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    if @rental.save
      redirect_to @rental, notice: 'Agendamento realizado com sucesso!'
    else
      @clients = Client.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def search
    @rentals = Rental.where('token LIKE UPPER (?)', "%#{params[:q]}%")
    render :search

  end

  private
  def rental_params
    params.require(:rental).permit(:start_date, :end_date,
                                   :car_category_id, :client_id)
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end
end