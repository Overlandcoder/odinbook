class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save!
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
      flash.now[:error] = "Comment couldn't be posted."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commenter_id)
  end
end
