class YearsController < ApplicationController
  before_action :authenticate_user!
  before_action :header_models_all, only: [:create, :show]
  before_action :configs_all      , only: [:create]

  def show
    @year = Year.find(params[:id])
    works_all(params[:sort])
    respond_to do |format|
      format.html
      format.csv { render csv: @works }
    end
  end

  def create
    @year = Year.new(year: Time.now.year)
    if @year.save
      flash[:success] = "Year(#{@year.year}) created!"
      redirect_to configs_url
    else
      render 'static_pages/configs'
    end
  end
end
