class AdminController < ApplicationController
  def index
    @articles = Article.includes(:user, :comments).all
  end

  def show_article
      @post = Article.find(params[:id])
  end

  def comments
  end

  def users
  end

  def articles
    @articles = Article.includes(:user).all

  end
end
