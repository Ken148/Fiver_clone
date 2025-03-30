class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get the current user's seller profile and their posts
    if current_user.seller_profile.present?
      # Fetch requests only for posts created by the logged-in user (the creator)
      @requests = Request.joins(:post)
                         .where(posts: { user_id: current_user.id })
    else
      # If the user doesn't have a seller profile, show a message or redirect
      redirect_to posts_path, alert: "You need to have a seller profile to view requests."
    end
  end

  # The rest of the controller remains unchanged
  def create
    @request = Request.new(request_params)
    @request.user = current_user

    if @request.save
      redirect_to requests_path, notice: "Your order has been sent successfully."
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:message, :price_range, :post_id)
  end
end
