class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ like unlike ]
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params) do |comment|
      comment.user = current_user
    end

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), status: :see_other
  end

  def like
    current_user.likes.create(likeable: @comment)
    render partial: 'comments/comment', locals: { comment: @comment }
  end

  def unlike
    current_user.likes.find_by(likeable: @comment).destroy
    render partial: 'comments/comment', locals: { comment: @comment }
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
