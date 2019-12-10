class ArticlesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
    @articles = current_user.articles.order(id: :desc).page(params[:page])
    end
  end

  def show
    @articles = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = 'ブログが正常に投稿されました'
      redirect_to @article
    else
      @articles = current_user.feed_articles.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ブログが投稿されませんでした'
      render :new
    end
  end

  def edit
    @articles = Article.find(params[:id])
  end

  def update
    @articles = Article.find(params[:id])
    
    if @article.update(article_params)
      flash[:success] = 'ブログは正常に更新されました'
      redirect_to @article
    else
      @articles = current_user.articles.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ブログは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash[:success] = 'ブログは正常に削除されました'
    redirect_to articles_url
  end
  
  private

  def article_params
    params.require(:article).permit( :title, :content)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      redirect_to root_url
    end
  end
end
