class AdminController < ApplicationController
  def index
  end

  def show_article
    @post = Article.find(params[:id])
  end

  def comments
  end

  def users
    @users = User.all
  end

  def articles
    @articles =
      Article.includes(%i[user rich_text_body]).paginate(
        page: params[:page],
        per_page: params[:per_page]
      )
  end
end
