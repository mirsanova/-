class CommentsController < ApplicationController
  before_action :set_article, only: [:create, :destroy, :show]

  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @comments = Comments.All
    @comment = @article.comments.new(comment_params)
    if @article.save
      redirect_to @article
    else
      render 'articles/show'
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :article_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
