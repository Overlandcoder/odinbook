class PostsController < ApplicationController
  def index
    @posts = Post.all.order("updated_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path
      flash[:notice] = "New post created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_back(fallback_location: root_path)
    flash[:alert] = "Post deleted."
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
