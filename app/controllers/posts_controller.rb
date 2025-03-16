class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:edit, :update, :show]
  before_action :set_gigs, only: [:edit, :new]  # Ensure @gigs is available for both new and edit actions

  def index
    if params[:search].present?
      @posts = Post.joins(:gig)
                   .where("posts.title LIKE :search OR gigs.title LIKE :search OR posts.content LIKE :search OR gigs.description LIKE :search", 
                          search: "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end

  def show
    # @post is already set by the before_action, no need to fetch it again
  end

  def new
    @post = current_user.posts.new
    @gig = @post.build_gig  # This builds a gig associated with this post
    @seller_profile = current_user.seller_profile
  end

  def create
    # Create a new Gig instance and associate it with the post
    @gig = Gig.new(gig_params)
    @gig.seller_profile = current_user.seller_profile  # Ensure gig is associated with seller_profile

    # Create the post and associate the gig with it
    @post = current_user.posts.new(post_params)
    @post.gig = @gig  # Link the gig to the post

    if @post.save
      redirect_to @post, notice: 'Post (Gig) was successfully created.'
    else
      render :new
    end
  end

  def edit
    @gig = @post.gig  # Ensure that you are accessing the associated gig in the edit form
  end

  def update
    # Update the post and gig separately if necessary
    if @post.update(post_params)
      @post.gig.update(gig_params) if gig_params.present?  # Update gig if gig_params is provided
      redirect_to @post, notice: 'Post (Gig) was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Set the post object before actions
  def set_post
    @post = Post.find(params[:id])  # This will raise ActiveRecord::RecordNotFound if the post doesn't exist
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: 'Post not found.'
  end

  # Ensure that @gigs is available for the new and edit actions
  def set_gigs
    @gigs = current_user.seller_profile.gigs # Access gigs through the user's seller profile
  end

  # Strong parameters for the post (make sure to permit gig_id as well)
  def post_params
    params.require(:post).permit(:title, :content, :gig_id)  # Ensure gig_id is included
  end

  # Strong parameters for the gig (nested under the post)
  def gig_params
    params.require(:post).require(:gig).permit(
      :title, :description, 
      :basic_price, :basic_description, :basic_image,
      :standard_price, :standard_description, :standard_image,
      :premium_price, :premium_description, :premium_image
    )
  end
end
