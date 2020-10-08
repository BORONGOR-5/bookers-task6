class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  # before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
   if @user == current_user
    render "edit"
   else
    redirect_to users_path
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end


  def followeruser
    @user = User.find(params[:id])
    @users = @user.followeruser
    render 'show_follower'
  end

  def followeduser
    @user = User.find(params[:id])
    @users = @user.followeduser
    render 'show_followed'
  end

  def index_search
    
  end
  # def search
  #   if params[:name].present?
  #     if params[:model] == "1"
  #       if params[:searched] == "1"
  #       @users = User.where('name LIKE ?', "#{params[:name]}")
  #       elsif params[:searched] == "2"
  #         @users = User.where('name LIKE ?', "#{params[:name]}%")
  #       elsif params[:searched] == "3"
  #         @users = User.where('name LIKE ?', "%#{params[:name]}")
  #       elsif params[:searched] == "4"
  #         @users = User.where('name LIKE ?', "%#{params[:name]}%")
  #       end
  #     elsif params[:model] == "2"
  #       if params[:searched] == "1"
  #       @users = User..where('name LIKE ?', "#{params[:name]}")
  #       elsif params[:searched] == "2"
  #         @users = User.where('name LIKE ?', "#{params[:name]}%")
  #       elsif params[:searched] == "3"
  #         @users = User.where('name LIKE ?', "%#{params[:name]}")
  #       elsif params[:searched] == "4"
  #         @users = User.where('name LIKE ?', "%#{params[:name]}%")
  #       end
  #     end
  #     render 'show_search_users'
  #   else
  #     @users = User.none
  #     render 'show_search_users'
  #   end
  # end






  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # def ensure_correct_user
  #   @user = User.find(params[:id])
  #   unless @user == current_user
  #     redirect_to user_path(current_user)
  #   end
  # end
  
  def correct_user
    user = User.find(params[:id])
   if current_user != user
    redirect_to user_path(current_user.id)
   end
  end
  
end
