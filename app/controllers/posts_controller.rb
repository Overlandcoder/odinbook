class PostsController < ApplicationController
  before_action :authenticate_user!

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
      redirect_to post_path(@post.id)
      flash[:success] = "New post created."
    else
      render :new, status: :unprocessable_entity
      flash.now[:error] = "The post couldn't be created, please fix the errors."
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
