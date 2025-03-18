class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:edit, :update, :show, :buy, :contact_creator, :send_message]

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
    @post = current_user.posts.build
    @gig = @post.build_gig  # Builds a new gig associated with the post
    @seller_profile = current_user.seller_profile
  end

  def create
    @post = current_user.posts.build(post_params)
    @gig = @post.build_gig(gig_params)
    @post.gig.seller_profile = current_user.seller_profile  # Associate gig with the seller profile

    if @post.save
      redirect_to @post, notice: 'Post (Gig) was successfully created.'
    else
      render :new
    end
  end

  def edit
    @gig = @post.gig  # Ensure the gig is correctly associated with the post for editing
  end

  def update
    if @post.update(post_params)
      @post.gig.update(gig_params) if gig_params.present?  # Update gig if there are changes
      redirect_to @post, notice: 'Post (Gig) was successfully updated.'
    else
      render :edit
    end
  end

  def buy
    head :ok  # Placeholder for future functionality when a user buys a gig
  end

  def contact_creator
    @user = @post.user  # Get the user (creator) of the post
    render 'contact'  # This will render the contact.html.erb template
  end

  def send_message
    message = params[:message]
    price_range = params[:price_range]

    # Ensure message and price range are present
    if message.present? && price_range.present?
      Message.create(post: @post, user: current_user, content: message, price_range: price_range)
      redirect_to @post, notice: 'Your message has been sent to the creator.'
    else
      redirect_to contact_creator_post_path(@post), alert: 'Message and price range are required.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])  # This will raise ActiveRecord::RecordNotFound if the post doesn't exist
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: 'Post not found.'
  end

  def post_params
    params.require(:post).permit(:title, :content)  # Ensure to permit all necessary fields for the post
  end

  def gig_params
    params.require(:post).require(:gig).permit(
      :title, :description, 
      :basic_price, :basic_description, :basic_image,
      :standard_price, :standard_description, :standard_image,
      :premium_price, :premium_description, :premium_image
    )
  end
end
