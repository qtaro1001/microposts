class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :followings, :followers]
                                        
  def show
   @user = User.find(params[:id])
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user.
    else
      render 'edit'
    end
  end
  
  def followings
    @user  = User.find(params[:id])
    @users = @user.following_relationships
    render 'followings'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.follower_relationships
    render 'followers'
  end

    
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :area,
                                 :profile)
  end
end
