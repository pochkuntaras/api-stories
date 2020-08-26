class ArticlesController < ApplicationController
  include Sortable

  before_action :set_articles, only: %i[index]
  before_action :set_article, only: %i[show update destroy]
  before_action :build_article, only: %i[create]

  after_action :publish_article, only: %i[update]

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
    params.slice(:story, :named, :text, :kind, :group_by_field)
  end

  def set_articles
    @articles = Article.includes(:story).filter_by(filter_params)
    @articles = @articles.reorder(sort) if params[:sort].present?
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

  def custom_sort_columns
    {
      id:         '"articles"."id"',
      name:       '"articles"."name"',
      kind:       '"articles"."kind"',
      story:      '"stories"."name"',
      created_at: '"articles"."created_at"',
      updated_at: '"articles"."updated_at"'
    }
  end

  def publish_article
    return if @article.errors.any?
    serialized_article = ArticleSerializer.new(@article).as_json
    ActionCable.server.broadcast('articles', article: serialized_article)
  end
end
