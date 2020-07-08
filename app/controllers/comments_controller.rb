class CommentsController < ApplicationController
  before_action :require_current_user!

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  def show
    @comment = Comment.includes(:child_comments, :post, :author).find(params[:id])
    render :show
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save!
      if @comment.parent_comment_id
        flash[:notice] = ["Comment created successfully"]
        redirect_to comment_url(@comment.parent_comment_id)
      else
        flash[:notice] = ["Comment created successfully"]
        redirect_to post_url(@comment.post)
      end
    else
      flash[:errors] = ["Invalid params, please try again"]
      redirect_to new_post_comment_url(@comment.post_id)
    end
  end

  def upvote
    upvote = Vote.new(user_id: current_user.id, value: 1, votable_type: "Comment", votable_id: params[:id])
    @comment = Comment.find(params[:id])
    @comment.increment(:score)
    @comment.save
    if upvote.save!
      flash[:notice] = ["Upvote successful!"]
      redirect_back(fallback_location: root_path)
    else
      flash[:errors] = ["Upvote unsuccessful, please try again"]
      redirect_back(fallback_location: root_path)
    end
  end

  def downvote
    downvote = Vote.new(user_id: current_user.id, value: -1, votable_type: "Comment", votable_id: params[:id])
    @comment = Comment.find(params[:id])
    @comment.decrement(:score)
    @comment.save
    if downvote.save!
      flash[:notice] = ["Downvote successful!"]
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = ["Downvote successful!"]
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end


end
