class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :followings, :followers]
  before_action :set_user, only: [:show, :edit, :update, 
                                        :followings, :followers]
                                        
  def show
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"      
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "FOLLOWING"
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "FOLLOWERS"
    @users = @user.follower_users
    render 'show_follow'
  end

  def index
    @title = "ALL USERS"
    @users = User.page(params[:page]).per(7)
  end
  
  private
  def set_user
    @user  = User.find(params[:id])  
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :area,
                                 :profile, :image)
  end
end
