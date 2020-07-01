class CommentsController < ApplicationController
  before_action :require_current_user!
  # before_action :require_user_owns_comment!, only: [:edit] #Uncomment if we want to add

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save!
      flash[:notice] = ["Comment created successfully"]
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = ["Invalid params, please try again"]
      redirect_to new_post_comment_url(@comment.post_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
