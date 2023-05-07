class SearchController < ApplicationController
  def index
    if !params[:q].empty?
      @query = params[:q]
      # @articles = Article.joins(:user).where("articles.title LIKE ? OR articles.body LIKE ? OR users.name LIKE ? OR users.email LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%", "%#{@query}%")
      @articles = Article.includes(:user, :rich_text_body).joins(:user,:category, :rich_text_body).where("articles.title ILIKE ? OR categories.name ILIKE ? OR action_text_rich_texts.body ILIKE ? OR users.first_name ILIKE ? OR users.last_name ILIKE ? OR users.email ILIKE ?", "%#{@query}%", "%#{@query}%","%#{@query}%", "%#{@query}%","%#{@query}%", "%#{@query}%").paginate(
        page: params[:page],
        per_page: params[:per_page]
      )
    else
      redirect_to root_path
    end
    # @query = Article.ransack(params[:q])
    # @articles = @query.result(distinct: true)
  end

  def autocomplete
    results = Article.where("title ILIKE ?", "%#{params[:q]}%").limit(10)
    render json: results
  end


end
