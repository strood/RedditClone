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

    @post = Post.create(post_params)
    @post.user_id = current_user.id

    # Will need to set this up to call a function that generates all the selected
    #  post_subs on the post creation page, for now, just the one
    @post_sub = PostSub.new(sub_id: params[:post][:sub_id])

    # puts @post.attributes

    # verify post has at least one sub/ can just make sure we make at least one
    #  post sub in the above function once we build it.
    if !@post_sub.sub_id
      flash[:errors] = ["You must select at least one sub for your post"]
      redirect_to new_post_url
    elsif @post.save!
      # now we have a post id to set, and can save our sub posts/ will make this
      # insert on each post sub when we have multiple
      @post_sub.post_id = @post.id
      if @post_sub.save!
        flash[:notice] = ["Post successfully created!"]
        redirect_to post_url(@post)
      else
        flash[:errors] = ["Issue making post_sub, please try again"]
        redirect_to new_post_url
      end
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
