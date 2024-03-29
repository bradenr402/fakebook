class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy like unlike ]
  before_action :authenticate_user!

  def index
    page_limit = 10
    @current_page = params[:page].to_i

    @posts = Post.includes(user: :avatar_attachment)
                 .where(user_id: current_user.followees)
                 .or(Post.includes(user: :avatar_attachment).where(user_id: current_user))
                 .offset(page_limit * @current_page).limit(page_limit)

    @next_page = @current_page + 1 if Post.count > page_limit * @current_page + page_limit
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
      redirect_to @post
    else
      flash[:error] = 'Something went wrong'
      render :new, staus: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated'
    else
      flash[:error] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, status: :see_other, notice: 'Post was successfully deleted'
  end

  def discover
    page_limit = 10
    @current_page = params[:page].to_i

    @posts = Post.includes(user: :avatar_attachment)
                 .offset(page_limit * @current_page).limit(page_limit)

    @next_page = @current_page + 1 if Post.count > page_limit * @current_page + page_limit

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
