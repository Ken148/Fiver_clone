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
    redirect_to posts_path, alert: 'Post not found.' if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content, :gig_id) # Ensure gig_id is permitted for the form
  end
end
