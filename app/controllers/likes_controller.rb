class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create(like_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.likes.find(params[:id])&.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
