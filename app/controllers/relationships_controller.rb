class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    followeruser = current_user.follow(@user)
    if followeruser.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to @user
    end
  end

  def destroy
    followeruser = current_user.unfollow(@user)
    if followeruser.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to @user
    end
  end

  private
  def set_user
    @user = User.find(params[:follower_id])
  end

end