# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
   deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @article = Article.find(params[:Comment][:article_id])
    @comment = Comment.find(params[:Comment][:id])
    @user = User.find(@comment.user_id)
    return "#{@user.full_name} commented on #{@article.title.truncate(10)}" unless @user == @article.user
  end
  #
  def url
    return article_path(Article.find(params[:Comment][:article_id])) unless params[:Comment][:user_id] == @article.user_id
  end
end
