class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(user_params)

    if @user.update(params[:user])
      flash[:success] = 'User was successfully updated'
      redirect_to @user
    else
      flash[:error] = 'Something went wrong'
      render :edit, status: :unprocessable_entity
    end
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_back(fallback_location: user_path(@user))
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
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
