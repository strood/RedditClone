class UsersController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]
  before_action :require_no_user!, only: [:create, :new]
  before_action :require_owning_user!, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.includes(:posts, :subs).find(params[:id])
    # @subs = Sub.find_by(moderator: @user.id)
    # @posts = Post.find_by(author: @user.id)
    render :show
  end


  def create

    @user = User.new(user_params)
    @user.admin = false
    if !params[:user][:password].nil? && User.pass_valid?(params[:user][:password])
      if @user.save!
        # @user.update_attribute(:admin, false)
        login!(@user)
        flash[:notice] = ["Hello #{@user.username}, welcome to Raddit"]
        redirect_to user_url(@user)
      else
        flash[:errors] = ["Invalid credentials, please try again"]
        redirect_to new_user_url
      end
    else
      flash[:errors] = ["Invalid password, please try again"]
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
