class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy like unlike ]
  before_action :authenticate_user!

  def index
    @posts = Post.includes(user: :avatar_attachment).where(user_id: current_user.followees)
                 .or(Post.includes(user: :avatar_attachment).where(user_id: current_user))
  end

  def show
    @post = Post.includes(user: :avatar_attachment, comments: { user: :avatar_attachment }).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to @post
    else
      flash[:error] = 'Something went wrong'
      render :new, staus: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post was successfully updated'
      redirect_to @post
    else
      flash[:error] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  def discover
    @posts = Post.includes(user: :avatar_attachment)
    render :index
  end

  def like
    current_user.likes.create(likeable: @post)
    if request.referrer == post_url(@post)
      render partial: 'posts/post', locals: { post: @post }
    else
      render partial: 'posts/post_link', locals: { post: @post }
    end
  end

  def unlike
    current_user.likes.find_by(likeable: @post).destroy
    if request.referrer == post_url(@post)
      render partial: 'posts/post', locals: { post: @post }
    else
      render partial: 'posts/post_link', locals: { post: @post }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
