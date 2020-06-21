class UsersController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end


  def create
    @user = User.new(user_params)
    @user.admin = false

    if @user.save!
      # @user.update_attribute(:admin, false)
      login!(@user)
      flash[:notice] = ["Hello #{@user.username}, welcome to Reddit"]
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid credentials, please try again"]
      redirect_to new_user_url
    end
  end

  # TODO: make update if we want to have a character edit page, but not
  #  yet sold on that idea.

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  # TODO: Write filter method to make sure user can only view their own user#show page
end
