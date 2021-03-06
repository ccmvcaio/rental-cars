class SubsidiariesController < ApplicationController
  before_action :set_subsidiary, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:index, :show, :new, :create,
                                            :edit, :update]
  
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
     redirect_to @subsidiary
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  private

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end
  
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
  
end