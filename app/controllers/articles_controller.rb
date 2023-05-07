class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  before_action :authenticate_user!
  # GET /articles or /articles.json
  def index
    @articles =
      Article.includes(%i[user rich_text_body]).paginate(
        page: params[:page],
        per_page: params[:per_page]
      )
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article.update(views: @article.views + 1)
    @comments =
      @article
        .comments
        .includes(%i[user rich_text_body])
        .order(created_at: :desc)
    ahoy.track "Viewed article", article_id: @article.id
    mark_notifications_as_read
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.includes([:rich_text_body]).find(params[:id])
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    respond_to do |format|
      if @article.save
        format.html do
          redirect_to article_url(@article),
                      notice: "Article was successfully created."
        end
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html do
          redirect_to article_url(@article),
                      notice: "Article was successfully updated."
        end
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @article.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html do
        redirect_to articles_url, notice: "Article was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.includes(%i[user rich_text_body]).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body, :category_id, pictures: [2])
  end

  def mark_notifications_as_read
    if current_user
      notifications_to_mark_as_read =
        @article.notifications_as_article.where(recipient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end
end
