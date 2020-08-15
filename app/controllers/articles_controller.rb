class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]

  respond_to :json

  def index
    @articles = Article.all
    respond_with @articles
  end

  def show
    respond_with @article
  end

  def create
    @article = Article.new(article_params)
    @article.save
    respond_with @article
  end

  def update
    @article.update(article_params)
    respond_with @article
  end

  def destroy
    @article.destroy
    respond_with @article
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:story_id, :name, :text, :kind)
  end
end
