class ApplicationController < ActionController::Base
  # include Pagy::Backend

  before_action :set_notifications, if: :current_user
  before_action :set_categories

  # before_action :set_query

  # def set_query
  #   @query = Article.ransack(params[:q])
  # end
  def is_admin?
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to do that."
    end
  end

  private

  def set_notifications
    notifications =
      Notification
        .includes([:recipient])
        .where(recipient: current_user)
        .newest_first
        .limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end

  def set_categories
    @categories = Category.where(display_in_nav: true)
  end
end
