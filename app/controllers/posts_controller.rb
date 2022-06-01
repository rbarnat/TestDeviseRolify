class PostsController < ApplicationController

  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  authorize_resource # charge le @post et vérifie les permissions

  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # If post is created confirm and show it, else show new form
    if @post.save!
      flash[:success] = "You created a new post!"
      redirect_to root_path
    else
      flash.now[:danger] = "Your post has not been created."
      render :new
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to root_path
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
