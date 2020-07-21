  class PostsController < ApplicationController
  before_action :require_current_user!, except: [:show]
  before_action :require_user_owns_post!, only: [:edit]

  def show
    @post = Post.friendly.includes(:author, :posted_subs).find(params[:id])
    @all_comments = @post.comments_by_parent_id
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
    unless params[:posted_sub_ids].nil?

      if @post.save!
        # now we have a post id to set, and can save our sub posts, done
        #  for us through the methods we gained from the post_subs association mentions above
        @post.posted_sub_ids = params[:posted_sub_ids].each

        flash[:notice] = ["Post successfully created!"]
        redirect_to post_url(@post)
      else
        flash[:errors] = ["Invalid credentials, please try again"]
        redirect_to new_post_url
      end
    else
      flash[:errors] = ["Post must belong to at least one sub"]
      redirect_to new_post_url
    end

  end


  def edit
    @post = Post.friendly.find(params[:id])
    render :edit
  end

  def update
    @post = Post.friendly.find(params[:id])
    unless !params[:posted_sub_ids]
      # This constructs our post_sub objects based on the selected subs in posts creation
      @post.posted_sub_ids = params[:posted_sub_ids].each
      if @post.update(post_params)
        flash[:notice] = ["Sucessfully updated post"]
        redirect_to post_url(@post)
      else
        flash[:errors] = ["Unable to update post"]
        redirect_to edit_post_url(@post)
      end
    else
      flash[:errors] = ["Post must belong to at least one sub"]
      redirect_to edit_post_url(@post)
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    if @post.destroy!
      flash[:notice] = ["Post deleted"]
      redirect_to subs_url
    else
      flash[:errors] = ["Unable to delete post"]
      redirect_to post_url(@post)
    end
  end

  def upvote
    @post = Post.friendly.find(params[:id])
    upvote = Vote.new(user_id: current_user.id, value: 1, votable_type: "Post", votable_id: @post.id)
    begin
      upvote.save!
      @post.increment(:score)
      @post.save
      flash[:notice] = ["Upvote successful!"]
      redirect_back(fallback_location: root_path)
    rescue
      flash[:errors] = ["Already voted on this post"]
      redirect_back(fallback_location: root_path)
    end
  end

  def downvote
    @post = Post.friendly.find(params[:id])
    downvote = Vote.new(user_id: current_user.id, value: -1, votable_type: "Post", votable_id: @post.id)
    begin
      downvote.save!
      @post.decrement(:score)
      @post.save
      flash[:notice] = ["Downvote successful!"]
      redirect_back(fallback_location: root_path)
    rescue
      flash[:errors] = ["Already voted on this post"]
      redirect_back(fallback_location: root_path)
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end


end
