class CommentsController < ApplicationController
  before_action :require_current_user!, only:[:new, :create, :upvote, :downvote]

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  def show
    @comment = Comment.friendly.includes(:child_comments, :post, :author).find(params[:id])
    render :show
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    begin
      if @comment.save!
        if @comment.parent_comment_id
          flash[:notice] = ["Comment created successfully"]
          redirect_to comment_url(@comment.parent_comment_id)
        else
          flash[:notice] = ["Comment created successfully"]
          redirect_to post_url(@comment.post)
        end
      end
    rescue Exception => e
      flash[:errors] = ["Invalid comment, please try again!"]
      redirect_back(fallback_location: root_path)
    end
  end


  def upvote
    @comment = Comment.friendly.find(params[:id])
    upvote = Vote.new(user_id: current_user.id, value: 1, votable_type: "Comment", votable_id: @comment.id)
    begin
      upvote.save!
      @comment.increment(:score)
      @comment.save
      flash[:notice] = ["Upvote successful!"]
      redirect_back(fallback_location: root_path)
    rescue
      flash[:errors] = ["Already voted on this comment"]
      redirect_back(fallback_location: root_path)
    end
  end

  def downvote
    @comment = Comment.friendly.find(params[:id])
    downvote = Vote.new(user_id: current_user.id, value: -1, votable_type: "Comment", votable_id: @comment.id)
    begin
      downvote.save!
      @comment.decrement(:score)
      @comment.save
      flash[:notice] = ["Downvote successful!"]
      redirect_back(fallback_location: root_path)
    rescue
      flash[:errors] = ["Already voted on this comment"]
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end


end
