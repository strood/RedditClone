class CommentsController < ApplicationController
  before_action :require_current_user!
  # before_action :require_user_owns_comment!, only: [:edit] #Uncomment if we want to add

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  def show
    @comment = Comment.includes(:child_comments).find(params[:id])
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

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

end
