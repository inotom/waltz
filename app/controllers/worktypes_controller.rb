class WorktypesController < ApplicationController
  before_action :authenticate_user!
  before_action :header_models_all    , only: [:new, :create, :edit, :update]
  before_action :select_worktype_by_id, only: [:edit, :update, :destroy]

  def new
    @worktype = Worktype.new
  end

  def create
    @worktype = Worktype.new(worktype_params)
    if @worktype.save
      flash[:success] = "Worktype created!"
      redirect_to configs_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @worktype.update_attributes(worktype_params)
      flash[:success] = "Worktype updated!"
      redirect_to configs_url
    else
      render 'edit'
    end
  end

  def destroy
    @worktype.destroy
    redirect_to configs_url
  end

  private

    def worktype_params
      params.require(:worktype).permit(:name)
    end

    def select_worktype_by_id
      @worktype = Worktype.find(params[:id])
    end
end
