class PostsController < ApplicationController 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :submit_review]
  before_action :set_post, only: [:edit, :update, :show, :buy, :contact_creator, :send_message, :submit_review]

  def index
    if params[:search].present?
      @posts = Post.joins(:gig)
                   .where("posts.title LIKE :search OR posts.content LIKE :search", search: "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end

  def show
    @reviews = @post.reviews  # Load all reviews associated with the post
  end

  def new
    @post = current_user.posts.new
    @seller_profile = current_user.seller_profile  # Assuming you still need to show the seller profile
  end

  def create
    # Build the post with basic parameters (title, content, and image)
    @post = current_user.posts.new(post_params)

    # Attach the image if uploaded (handling it outside of strong params)
    if params[:post][:image].present?
      @post.image.attach(params[:post][:image])
    end

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    # No need to access @gig anymore as you don't use it in the view
  end

  def update
    # Attach the image if uploaded (handling it outside of strong params)
    if params[:post][:image].present?
      @post.image.purge_later # Purge the old image before attaching a new one
      @post.image.attach(params[:post][:image])
    end

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def buy
    head :ok  # Placeholder action for buying the post
  end

  def contact_creator
    @user = @post.user  # Get the user (creator) of the post
    render 'contact'  # This will render the contact.html.erb template
  end

  def send_message
    message = params[:message]
    price_range = params[:price_range]

    if message.present? && price_range.present?
      Message.create(post: @post, user: current_user, content: message, price_range: price_range)
      redirect_to @post, notice: 'Your message has been sent to the creator.'
    else
      redirect_to contact_creator_post_path(@post), alert: 'Message and price range are required.'
    end
  end

  def submit_review
    @review = @post.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @post, notice: 'Your review has been submitted successfully.'
    else
      redirect_to @post, alert: 'Failed to submit review.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: 'Post not found.'
  end

  # Strong parameters for the post (only the fields you need)
  def post_params
    params.require(:post).permit(:title, :content)  # Remove :image from strong params
  end

  def review_params
    params.permit(:comment, :rating)  # Allow top-level comment and rating parameters
  end
end
