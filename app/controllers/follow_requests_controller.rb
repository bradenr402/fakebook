class FollowRequestsController < ApplicationController
  def index
    @requests = FollowRequest.all
  end

  def create
    @user = User.find(params[:followee_id])
    @request = @user.follow_requests.build(request_params)

    if @request.save
      flash[:success] = 'Follow request successfully sent'
      # redirect_to users_path(@user)
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to users_path(@user)
  end

  def destroy
    @request = FollowRequest.find(params[:id])
    if @request.destroy
      flash[:success] = 'Follow request successfully canceled'
      # redirect_to user_path(@request.followee)
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to user_path(@request.followee)
  end

  def accept
    @request = FollowRequest.find(params[:id])
    @request.accept!
    redirect_back(fallback_location: user_path(current_user))
  end

  def decline
    @request = FollowRequest.find(params[:id])
    @request.decline!
    redirect_back(fallback_location: user_path(current_user))
  end

  private

  def request_params
    params.require(:request).permit(:follower_id, :followee_id)
  end
end
