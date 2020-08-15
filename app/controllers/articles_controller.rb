class ArticlesController < ApplicationController
  before_action :set_articles, only: %i[index]
  before_action :set_article, only: %i[show update destroy]
  before_action :build_article, only: %i[create]

  respond_to :json

  def index
    respond_with @articles
  end

  def show
    respond_with @article
  end

  def create
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

  def filter_params
    params.slice(:story, :named, :text, :kind)
  end

  def set_articles
    @articles = Article.filter_by(filter_params)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def build_article
    @article = Article.new(article_params)
  end

  def article_params
    params.require(:article).permit(:story_id, :name, :text, :kind)
  end
end
