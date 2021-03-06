# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update show delete]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    @article.user_id = User.first.id
    if @article.save
      flash[:notice] = 'Article saved successfully'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = 'Article updated successfully'
      redirect_to article_path(@article)
    else
      flash[:error] = @article.errors.full_messages
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = 'Article deleted successfully!'
      redirect_to articles_path
    else
      render 'index'
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
