class RequestsController < ApplicationController
  before_action :authenticate_user!

  # Show requests for the current user or specific posts created by the logged-in user
  def index
    if current_user.seller_profile.present?
      # Fetch requests for posts created by the logged-in user (the creator)
      @requests = Request.joins(:post)
                         .where(posts: { user_id: current_user.id })
    else
      redirect_to posts_path, alert: "You need to have a seller profile to view requests."
    end
  end

  # Show a single request and its associated messages
  def show
    @request = Request.find(params[:id])
  end

  # Create a new request
  def create
    @request = Request.new(request_params)
    @request.user = current_user

    if @request.save
      redirect_to requests_path, notice: "Your order has been sent successfully."
    else
      render :new
    end
  end

  # Create a new message for a specific request (the feedback between users and creators)
  def create_message
    @request = Request.find(params[:request_id])  # Find the specific request
    @message = @request.messages.build(message_params)
    @message.user = current_user  # Assign the current user as the sender

    if @message.save
      redirect_to request_path(@request), notice: "Message sent successfully."
    else
      render :show  # Handle error if necessary
    end
  end

  private

  # Strong parameters for creating a request
  def request_params
    params.require(:request).permit(:message, :price_range, :post_id)
  end

  # Strong parameters for creating a message
  def message_params
    params.require(:message).permit(:content)  # Only allow content to be sent as a message
  end
end
