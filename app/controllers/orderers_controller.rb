class OrderersController < ApplicationController
  before_action :authenticate_user!
  before_action :header_models_all   , only: [:new, :create, :edit, :update]
  before_action :select_orderer_by_id, only: [:edit, :update, :destroy]

  def new
    @orderer = Orderer.new
  end

  def create
    @orderer = Orderer.new(orderer_params)
    if @orderer.save
      flash[:success] = "Orderer created!"
      redirect_to configs_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @orderer.update_attributes(orderer_params)
      flash[:success] = "Orderer updated!"
      redirect_to configs_url
    else
      render 'edit'
    end
  end

  def destroy
    @orderer.destroy
    redirect_to configs_url
  end

  private

    def orderer_params
      params.require(:orderer).permit(:name, :color_index)
    end

    def select_orderer_by_id
      @orderer = Orderer.find(params[:id])
    end
end
