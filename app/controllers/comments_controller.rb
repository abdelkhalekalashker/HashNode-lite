class CommentsController < ApplicationController

    before_action :set_article
    before_action :authenticate_user!

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        @comment.user = current_user

        if @comment.save!
            flash[:notice] = "Comment has been created"
            redirect_to article_path(@article)
        else
            flash[:alert] = "Comment hasn't been created"
            redirect_to article_path(@article)
        end

    end

    def update
        @comment = @article.comments.find(params[:id])
        if @comment.update(comment_params)
            flash[:notice] = "Comment has been updateded"
            redirect_to article_path(@article)
        else
            flash[:alert] = "Comment hasn't been updated"
            redirect_to article_path(@article)
        end
    end

    def destroy
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
    end

    private

    def set_article
        @article = Article.find(params[:article_id])
    end
    def comment_params
        params.require(:comment).permit(:body)
    end
end
