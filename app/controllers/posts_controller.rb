class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:edit, :update, :show]

  def index
    if params[:search].present?
      # Perform a search on both post and gig titles, and post content and gig descriptions
      @posts = Post.joins(:gig)
                   .where("posts.title LIKE :search OR gigs.title LIKE :search OR posts.content LIKE :search OR gigs.description LIKE :search", 
                          search: "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end

  def show
    # @post is already set by before_action, no need to fetch it again
  end

  def new
    @post = current_user.posts.new
    # If needed, add logic to allow the user to select a gig here, or assign a default
    # For example, you could populate @gigs to display them for the user to choose
    @gigs = current_user.gigs  # Assuming a user has multiple gigs (posts) 
  end

  def create
    # Ensure the post is associated with a gig
    @post = current_user.posts.new(post_params)
    # If gig_id is not provided, redirect back with an error or automatically associate it
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    # @post is already set by before_action, no need to fetch it again
    @gigs = current_user.gigs  # Allow user to change the gig association
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
    @post = Post.find(params[:id])  # This will raise ActiveRecord::RecordNotFound if the post doesn't exist
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: 'Post not found.'
  end

  def post_params
    params.require(:post).permit(:title, :content, :gig_id)  # Ensure gig_id is included
  end
end
