class UsersController < ApplicationController
  before_action :set_user

  def profile
    @user.update!(views: @user.views + 1)
    @articles =
      @user.articles.includes(:rich_text_body).order(created_at: :desc)

    @total_views = 0
    @articles.each { |article| @total_views += article.views }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
