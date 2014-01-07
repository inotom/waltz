class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def header_models_all
    @years = Year.all
  end

  def configs_all
    @orderers = Orderer.all
    @worktypes = Worktype.all
  end

  def works_all(sort)
    @sort = sort.nil? ? 'start_date' : sort
    if !sort.nil? && @sort == session[:sort]
      # ソート方向のトグル
      @direction = session[:direction] == 'asc' ? 'desc' : 'asc'
    else
      @direction = 'desc'
    end
    # セッション保存
    session[:sort] = @sort
    session[:direction] = @direction
    # データ読み出し
    # reorder でデフォルトスコープの order を書き換える
    @works = @year.works.reorder("#{@sort} #{@direction}")
  end
end
