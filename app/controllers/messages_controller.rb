class MessagesController < ApplicationController
    before_action :authenticate_user!  # Ensure the user is logged in
    include Rails.application.routes.url_helpers # Include the URL helpers to use request_path
  
    def create
      # Find the request by its ID from the URL
      @request = Request.find(params[:request_id])
  
      # Build a new message associated with the request
      @message = @request.messages.build(message_params)
      @message.user = current_user  # Associate the logged-in user as the sender
  
      # Save the message and determine where to redirect
      if @message.save
        flash[:notice] = "Message sent successfully."
  
        # Check if the request was coming from orders or requests page
        if request.referer.include?('orders')  # If the referer URL includes 'orders', redirect to orders page
          redirect_to orders_path  # Redirect to the orders page (or use the appropriate path for orders)
        else  # If not, assume it's coming from requests page
          redirect_to requests_path  # Redirect to the requests index page (or use the appropriate path for requests)
        end
      else
        # If the message fails to save, show an error and stay on the current page
        flash[:alert] = "Failed to send message."
        redirect_to request_path(@request)  # Redirect to the same request page
      end
    end
  
    private
  
    # Strong parameters for the message
    def message_params
      params.require(:message).permit(:content)  # Only allow content for the message
    end
  end
  