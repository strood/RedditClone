class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)

    if @comment.save!
      flash[:notice] = ["Comment created successfully"]
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = ["Invalid params, please try again"]
      redirect_to new_post_comment_url(@comment.post_id)
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
