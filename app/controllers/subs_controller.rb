class SubsController < ApplicationController

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.create(sub_params)
    @sub.moderator = current_user.id

  if @sub.save!
    flash[:notice] = ["Sub #{@sub.title} successfully created!"]
    redirect_to sub_url(@sub)
  else
    flash[:errors] = ["Invalid credentials, please try again"]
    redirect_to new_sub_url
  end

  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      flash[:notice] = ["Sucessfully updated #{@sub.title}"]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Unable to update sub"]
      redirect_to sub_url(@sub)
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub.destroy!
      flash[:notice] = ["Sub: #{@sub.title} successfully deleted"]
      redirect_to subs_url
    else
      flash[:errors] = ["Unable to destroy #{@sub.title}"]
      redirect_to sub_url(@sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
