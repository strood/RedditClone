class SubsController < ApplicationController
  before_action :require_current_user!, except: [:index, :show]
  before_action :require_user_owns_sub!, only: [:edit]

  def index
    if !params[:sub].nil?
      if ['0', '1', '2'].include?(params[:sub][:option])
        opt = [:title, :created_at, created_at: :desc]
        @subs = Sub.order(opt[params[:sub][:option].to_i]).includes(:moderator).page params[:page]
        render :index
      else
        flash[:errors] = ["Invalid Order!"]
        @subs = Sub.order(:title).includes(:moderator).page params[:page]
        render :index
      end
    else
      @subs = Sub.order(:title).includes(:moderator).page params[:page]
      render :index
    end
  end


  def show
    @sub = Sub.friendly.includes(:moderator).find(params[:id])
    # Paginating the query directly led to mis-ordering, now we have it
    # turning an array into a paginatable object then using that in the view, after
    # being sorted beforehand, then ...reversed? Looks ugly should simplify.
    if !params[:sub].nil?
      if ['0', '1', '2', '3'].include?(params[:sub][:option])
        options = [:score, :title, :created_at, created_at: :desc]
        @post_order = options[params[:sub][:option].to_i]
        if @post_order == :score
          @sub_posts = @sub.sub_posts.includes(:author, :votes, :posted_subs).order(@post_order).reverse
        else
          @sub_posts = @sub.sub_posts.includes(:author, :votes, :posted_subs).order(@post_order)
        end
        @paginate_posts = Kaminari.paginate_array(@sub_posts).page(params[:page]).per(10)
        render :show
      else
        flash[:errors] = ["Invalid Order!"]
        @post_order = :score
        @sub_posts = @sub.sub_posts.includes(:author, :votes, :posted_subs).order(@post_order).reverse
        @paginate_posts = Kaminari.paginate_array(@sub_posts).page(params[:page]).per(10)
        render :show
      end
    else
      @post_order = :score
      @sub_posts = @sub.sub_posts.includes(:author, :votes, :posted_subs).order(@post_order).reverse
      @paginate_posts = Kaminari.paginate_array(@sub_posts).page(params[:page]).per(10)
      render :show
    end

  end


  def new
    @sub = Sub.new
    render :new
  end


  def create
    @sub = Sub.create(sub_params)
    @sub.user_id = current_user.id
    @sub_check = Sub.friendly.find_by(title: @sub.title)
    if !@sub_check.nil?
      flash[:errors] = ["Location already added!"]
      redirect_to sub_url(@sub_check.id)
    else
      begin
        if @sub.save!
          flash[:notice] = ["#{@sub.title} successfully added!"]
          redirect_to sub_url(@sub)
        end
      rescue Exception => e
        flash[:errors] = [e.message]
        redirect_to new_sub_url
      end
    end
  end


  def edit
    @sub = Sub.friendly.find(params[:id])
    render :edit
  end


  def update
    @sub = Sub.friendly.find(params[:id])
    begin
      if @sub.update(sub_params)
        flash[:notice] = ["Sucessfully updated #{@sub.title}"]
        redirect_to sub_url(@sub)
      end
    rescue Exception => e
      flash[:errors] = ["Unable to update #{ @sub.title }"]
      flash[:errors] << e.message
      redirect_to sub_url(@sub)
    end
  end

  def destroy
    @sub = Sub.friendly.find(params[:id])
    begin
      if @sub.destroy!
        flash[:notice] = ["#{@sub.title} successfully deleted"]
        redirect_to subs_url
      end
    rescue Exception => e
      flash[:errors] = ["Unable to destroy #{@sub.title}"]
      flash[:errors] << e.message
      redirect_to sub_url(@sub)
    end
  end

  def subscribe
    @sub = Sub.friendly.find(params[:id])
    unless UserSub.find_by(sub_id: @sub.id, user_id: current_user.id)
      @user_sub = UserSub.new(sub_id: @sub.id, user_id: current_user.id)
      if @user_sub.save!
        flash[:notice] = ["Subscribed to #{ @sub.title }!"]
        redirect_back(fallback_location: root_path)
      else
        flash[:errors] = ["Unable to subscribe to #{ @sub.title }"]
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
        flash[:notice] = ["Unsubscribed from #{ @sub.title }!"]
        redirect_back(fallback_location: root_path)
      else
        flash[:errors] = ["Unable to unsubscribe from #{ @sub.title }"]
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:errors] = ["You are not subscribed to #{ @sub.title }"]
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :option)
  end
end
