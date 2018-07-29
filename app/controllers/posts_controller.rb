class PostsController < ApplicationController

  def new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = Post.create(post_params)
    if post
      redirect_to post_path(post)
    else
      flash[:error] = post.errors.full_messages.join(", ")
      redirect_back fallback_location: root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
