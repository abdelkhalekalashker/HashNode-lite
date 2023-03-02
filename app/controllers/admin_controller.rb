class AdminController < ApplicationController
  def index
    @articles = Article.all.includes(:user, :comments)
  end

  def show_article
      @post = Article.includes(:user, :comments).find(params[:id])
  end

  def comments
  end

  def users
  end

  def articles
    @articles = Article.all.includes(:user, :comments)

  end
end
