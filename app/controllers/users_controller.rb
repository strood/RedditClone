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
    @existing_user = User.find_by(username: @user.username)
    if !@existing_user.nil?
      flash[:errors] = ["Username already taken, please try another"]
      redirect_to new_user_url
    else
      begin
        if @user.save!
          login!(@user)
          flash[:notice] = ["Hello #{@user.username}, welcome to Foodie"]
          redirect_to user_url(@user)
        end
      rescue Exception => e
        flash[:errors] = [e.message]

        redirect_to new_user_url
      end
    end
  end

  def subscriptions
    if !params[:user].nil?
      if ['0', '1', '2', '3'].include?(params[:user][:option])
        options = [:score, :title, :created_at, created_at: :desc]
        @post_order = options[params[:user][:option].to_i]
        @user = User.friendly.includes(:subscriptions).find(params[:id])
        if @post_order == :score
          @posts = User.subscription_posts(@user.subscriptions, @post_order).reverse
        else
          @posts = User.subscription_posts(@user.subscriptions, @post_order)
        end
        @paginatable_posts = Kaminari.paginate_array(@posts).page(params[:page]).per(15)
        render :subscriptions
      else
        flash[:errors] = ["Invalid Order!"]
        @post_order = :score
        @user = User.friendly.includes(:subscriptions).find(params[:id])
        @posts = User.subscription_posts(@user.subscriptions, @post_order)
        @paginatable_posts = Kaminari.paginate_array(@posts).page(params[:page]).per(15)
        render :subscriptions
      end
    else
      @post_order = :score
      @user = User.friendly.includes(:subscriptions).find(params[:id])
      @posts = User.subscription_posts(@user.subscriptions, @post_order).reverse
      @paginatable_posts = Kaminari.paginate_array(@posts).page(params[:page]).per(15)
      render :subscriptions
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end


end
