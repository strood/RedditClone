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

    @post.user_id = current_user.id
    puts "hi"
    puts post_params
    # Will need to set this up to call a function that generates all the selected
    #  post_subs on the post creation page, for now, just the one
    # TO DO THIS USE Post#sub_ids=, will make all changes auto

    # puts @post.attributes

    # verify post has at least one sub/ can just make sure we make at least one
    #  post sub in the above function once we build it.

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
