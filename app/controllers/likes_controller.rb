class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(like_params)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @like = @post.likes.find_by(like_params)

    if @like.destroy
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
