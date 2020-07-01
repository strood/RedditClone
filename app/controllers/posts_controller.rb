class PostsController < ApplicationController
  before_action :require_current_user!
  before_action :require_user_owns_post!, only: [:edit]

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

    @post.user_id = current_user.id

    # Becuase we get additional methods from our association of posts and post_subs
    #  when post.save gets called, Post.sub_ids= is also called, and our checked
    #  subs are all created in relation to this post. handling all that for us.
    if @post.save!
      # now we have a post id to set, and can save our sub posts/ will make this
      # insert on each post sub when we have multiple
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

    # This constructs our post_sub objects based on the selected subs in posts creation
    @post.posted_sub_ids = params[:posted_sub_ids]
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
      redirect_to subs_url # TODO Change this to be the destroyed posts sub
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
