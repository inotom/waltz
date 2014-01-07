class WorksController < ApplicationController
  before_action :authenticate_user!
  before_action :header_models_all, only: [:new, :create, :edit, :update]
  before_action :configs_all      , only: [:new, :edit]
  before_action :select_work_by_id, only: [:edit, :update, :destroy]

  def new
    year = Year.first
    if year.nil?
      year = Year.new(year: Time.now.year)
      year.save
    end
    @work = year.works.build
  end

  def create
    @work = Year.first.works.build(work_params)
    if @work.save
      flash[:success] = "Work created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @year = @work.year
  end

  def update
    if @work.update_attributes(work_params)
      flash[:success] = "Work updated!"
      year = @work.year
      redirect_to year_path(year)
    else
      render 'edit'
    end
  end

  def destroy
    year = @work.year
    @work.destroy
    redirect_to year_path(year)
  end

  private

    def work_params
      params.require(:work).permit(:start_date,
                                   :end_date,
                                   :claim_date,
                                   :receipt_date,
                                   :memo,
                                   :orderer_id,
                                   :worktype_id,
                                   :quote_amount,
                                   :receipt_amount,
                                   :year_id,
                                   :title)
    end

    def select_work_by_id
      @work = Work.find(params[:id])
    end
end
