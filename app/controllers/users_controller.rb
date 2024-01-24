class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    page_limit = 10
    @current_page = params[:page].to_i

    @users = User.includes(:avatar_attachment).where.not(id: current_user.id)
                 .offset(page_limit * @current_page).limit(page_limit)

    @next_page = @current_page + 1 if User.count > page_limit * @current_page + page_limit
  end

  def show
    @user = User.find(params[:id]) == current_user ? User.includes(follow_requests: :follower).find(params[:id]) : User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    current_user.request_to_follow(@user)
    redirect_back(fallback_location: user_path(@user))
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    FollowRequest.find_by(follower_id: current_user.id, followee_id: @user.id)&.destroy

    redirect_back(fallback_location: user_path(@user))
  end

  def followers
    @user = User.includes(:avatar_attachment).find(params[:id])
    @users = @user.followers.includes(:avatar_attachment)
    @title = 'Followers'

    render 'show_follow'
  end

  def following
    @user = User.includes(:avatar_attachment).find(params[:id])
    @users = @user.followees.includes(:avatar_attachment)
    @title = 'Following'

    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
