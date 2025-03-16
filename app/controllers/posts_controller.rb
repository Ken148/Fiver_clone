class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:edit, :update, :show]

  def index
    if params[:search].present?
      @posts = Post.joins(:gig).where("posts.title LIKE ? OR gigs.title LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end

  def show
    # No need to call Post.find since set_post already loads the post
  end

  def new
    @post = current_user.posts.new
    @gigs = current_user.gigs # Allow the user to select a gig
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      @gigs = current_user.gigs # Allow the user to choose gigs again if errors occur
      render :new
    end
  end

  def edit
    @gigs = current_user.gigs # Allow the user to select a gig for the post
  end

  def update
    # No need to call current_user.posts.find as @post is already set by set_post
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      @gigs = current_user.gigs # Allow the user to choose gigs again if errors occur
      render :edit
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    # If no post is found, redirect to posts list with an alert
    redirect_to posts_path, alert: 'Post not found.' if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content, :gig_id) # Ensure gig_id is permitted for the form
  end
end
