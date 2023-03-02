class SearchController < ApplicationController
  def index
    @query = params[:q]
    # @articles = Article.joins(:user).where("articles.title LIKE ? OR articles.body LIKE ? OR users.name LIKE ? OR users.email LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%")
    @articles = Article.joins(:user, :rich_text_body).where("articles.title LIKE ? OR action_text_rich_texts.body LIKE ? OR users.name LIKE ? OR users.email LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%")

    # @query = Article.ransack(params[:q])
    # @articles = @query.result(distinct: true)
  end
end
