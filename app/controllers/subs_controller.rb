class SubsController < ApplicationController
  before_action :require_current_user!, except: [:index, :show]
  before_action :require_user_owns_sub!, only: [:edit]

  def index
    @subs = Sub.includes(:moderator).page(1).per(10)
    render :index
  end


  def show
    @sub = Sub.friendly.includes(:moderator).find(params[:id])
    render :show
  end


  def new
    @sub = Sub.new
    render :new
  end


  def create
    @sub = Sub.create(sub_params)
    @sub.user_id = current_user.id

    if @sub.save!
      flash[:notice] = ["Sub #{@sub.title} successfully created!"]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Invalid credentials, please try again"]
      redirect_to new_sub_url
    end
  end


  def edit
    @sub = Sub.friendly.find(params[:id])
    render :edit
  end


  def update
    @sub = Sub.friendly.find(params[:id])
    if @sub.update(sub_params)
      flash[:notice] = ["Sucessfully updated #{@sub.title}"]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Unable to update sub"]
      redirect_to sub_url(@sub)
    end
  end

  def destroy
    @sub = Sub.friendly.find(params[:id])
    if @sub.destroy!
      flash[:notice] = ["Sub: #{@sub.title} successfully deleted"]
      redirect_to subs_url
    else
      flash[:errors] = ["Unable to destroy #{@sub.title}"]
      redirect_to sub_url(@sub)
    end
  end

  def subscribe
    @sub = Sub.friendly.find(params[:id])
    unless UserSub.find_by(sub_id: @sub.id, user_id: current_user.id)
      @user_sub = UserSub.new(sub_id: @sub.id, user_id: current_user.id)
      if @user_sub.save!
        flash[:notice] = ["Subscribed!"]
        redirect_back(fallback_location: root_path)
      else
        flash[:errors] = ["Unable to subscribe"]
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:errors] = ["You already subscribe to #{ @sub.title }"]
      redirect_back(fallback_location: root_path)
    end
  end

  def unsubscribe
    @sub = Sub.friendly.find(params[:id])
    @user_sub = UserSub.find_by(sub_id: @sub.id, user_id: current_user.id)
    if @user_sub
      if @user_sub.destroy!
        flash[:notice] = ["Unsubscribed!"]
        redirect_back(fallback_location: root_path)
      else
        flash[:errors] = ["Unable to unsubscribe"]
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:errors] = ["You are not subscribed to #{ @sub.title }"]
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
