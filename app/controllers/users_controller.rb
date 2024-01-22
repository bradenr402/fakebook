class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:avatar_attachment).where.not(id: current_user)
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
    @user = User.find(params[:id])
    @users = @user.followers
    @title = 'Followers'

    render 'show_follow'
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followees
    @title = 'Following'

    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
