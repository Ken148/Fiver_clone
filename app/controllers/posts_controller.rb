class PostsController < ApplicationController 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :submit_review]
  before_action :set_post, only: [:edit, :update, :show, :buy, :contact_creator, :send_message, :submit_review]

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
    @reviews = @post.reviews  # Load all reviews associated with the post
  end

  def new
    @post = current_user.posts.new
    @gig = @post.build_gig  # This builds a gig associated with this post
    @seller_profile = current_user.seller_profile
  end

  def create
    # Build a new gig and associate it with the post
    @gig = Gig.new(gig_params)
    @gig.seller_profile = current_user.seller_profile  # Ensure gig is associated with seller_profile

    # Create the post and associate the gig with it
    @post = current_user.posts.new(post_params)
    @post.gig = @gig  # Link the gig to the post

    if @post.save && @gig.save
      redirect_to @post, notice: 'Post (Gig) was successfully created.'
    else
      render :new
    end
  end

  def edit
    @gig = @post.gig  # Ensure you're accessing the associated gig in the edit form
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

  # Placeholder buy action
  def buy
    # This action will do nothing for now, you can handle redirects or logging here
    head :ok
  end

  # Action to render the contact page
  def contact_creator
    @user = @post.user  # Get the user (creator) of the post
    # No need to process the message here; the contact form will handle that
    render 'contact'  # This will render the contact.html.erb template
  end

  # Action to handle the form submission
  def send_message
    message = params[:message]
    price_range = params[:price_range]

    # Ensure message and price range are present
    if message.present? && price_range.present?
      # Create the message object or handle the contact request here
      Message.create(post: @post, user: current_user, content: message, price_range: price_range)
      
      # Optionally, send an email or notification to the creator here.
      
      redirect_to @post, notice: 'Your message has been sent to the creator.'
    else
      redirect_to contact_creator_post_path(@post), alert: 'Message and price range are required.'
    end
  end

  # Action to handle review submission
  def submit_review
    @review = @post.reviews.new(review_params)  # Use the updated review_params
    @review.user = current_user  # Associate the current user with the review

    if @review.save
      redirect_to @post, notice: 'Your review has been submitted successfully.'
    else
      redirect_to @post, alert: 'Failed to submit review.'
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

  # Strong parameters for review submission
  def review_params
    params.permit(:comment, :rating)  # Allow top-level comment and rating parameters directly
  end
end
