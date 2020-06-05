class UsersController < ApplicationController


  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find_by(params[:id])
    render :show
  end


  def create
    @user = User.new(user_params)

    if @user.save!
      flash[:notice] = ["Hello #{@user.username}, welcome to Reddit"]
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid credentials, please try again"]
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
