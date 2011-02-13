class ArticlesController < ApplicationController
  def index
    @archives = Archives.archive
    @article = @archives.shift
  end

  def show
    @article = Article.find_by_permalink(params[:year], params[:month], params[:day], params[:slug])
  end
end
