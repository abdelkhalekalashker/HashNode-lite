class SearchController < ApplicationController
  def index
    @query = params[:q]
    # @articles = Article.joins(:user).where("articles.title LIKE ? OR articles.body LIKE ? OR users.name LIKE ? OR users.email LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%")
    @articles = Article.includes(:user, :rich_text_body).joins(:user,:category, :rich_text_body).where("articles.title ILIKE ? OR categories.name ILIKE ? OR action_text_rich_texts.body ILIKE ? OR users.first_name ILIKE ? OR users.last_name ILIKE ? OR users.email ILIKE ?", "%#{@query}%", "%#{@query}%","%#{@query}%", "%#{@query}%","%#{@query}%", "%#{@query}%")

    # @query = Article.ransack(params[:q])
    # @articles = @query.result(distinct: true)
  end
end
