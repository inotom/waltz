class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :header_models_all, only: [:home, :configs]
  before_action :configs_all, only: [:configs]

  def home
    if Year.first.nil?
      @year = Year.new(year: Time.now.year)
      @year.save
    else
      @year = Year.first
    end
    works_all(params[:sort])
  end

  def configs
  end
end
