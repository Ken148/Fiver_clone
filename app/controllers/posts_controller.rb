class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:edit, :update, :show]

  def index
    if params[:search].present?
      # Perform a search on both post and gig titles, and post content and gig descriptions
      @posts = Post.joins(:gig)
                   .where("posts.title LIKE ? OR gigs.title LIKE ? OR posts.content LIKE ? OR gigs.description LIKE ?", 
                          "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    redirect_to posts_path, alert: 'Post not found.' if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
