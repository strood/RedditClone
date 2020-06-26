class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save!
      flash[:notice] = ["Post successfully created!"]
      redirect_to post_url(@post)
    else
      flash[:errors] = ["Invalid credentials, please try again"]
      redirect_to new_post_url
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = ["Sucessfully updated post"]
      redirect_to post_url(@post)
    else
      flash[:errors] = ["Unable to update post"]
      redirect_to post_url(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy!
      flash[:notice] = ["Post deleted"]
      redirect_to sub_url(@post.sub)
    else
      flash[:errors] = ["Unable to delete post"]
      redirect_to post_url(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
