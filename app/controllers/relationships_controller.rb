class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    followeruser = current_user.follow(@user)
    if followeruser.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    followeruser = current_user.unfollow(@user)
    if followeruser.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def set_user
    @user = User.find(params[:follower_id])
  end

end