class UsersController < ApplicationController
  before_action :require_current_user!, except: [:create, :new, :show]
  before_action :require_no_user!, only: [:create, :new]
  before_action :require_user_is_user!, only: [:edit]

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.friendly.includes(:subs, :votes, :posts, :comments).find(params[:id])
    render :show
  end


  def create

    @user = User.new(user_params)
    @user.admin = false

    if !params[:user][:password].nil? && User.pass_valid?(params[:user][:password])
      @existing_user = User.find_by(username: @user.username)
      begin
        if @user.save!
          login!(@user)
          flash[:notice] = ["Hello #{@user.username}, welcome to Foodie"]
          redirect_to user_url(@user)
        else
          flash[:errors] = ["Invalid credentials, please try again"]
          redirect_to new_user_url
        end
      rescue Exception => e
        flash[:errors] = ["Username already taken, please try another"]
        redirect_to new_user_url
      end
    else
      flash[:errors] = ["Invalid password, please try again"]
      redirect_to new_user_url
    end
  end

  def subscriptions
    @user = User.friendly.includes(:subscriptions).find(params[:id])
    @posts = User.subscription_posts(@user.subscriptions)
    @paginatable_posts = Kaminari.paginate_array(@posts).page(params[:page]).per(15)
    render :subscriptions
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
