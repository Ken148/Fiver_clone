class OrdersController < ApplicationController
  before_action :authenticate_user!

  # Order creation
  def create
    @post = Post.find(params[:post_id])  # Ensure the post_id is correctly passed from the form

    # Create an order for the current user and the post they want to order
    @order = Order.new(order_params)
    @order.user = current_user
    @order.post = @post
    @order.status = "Pending" # Or any status you want to set initially

    if @order.save
      flash[:notice] = "Your message has been sent to the creator."
      redirect_to orders_path # Redirect to the user's orders page
    else
      flash[:alert] = "There was an issue placing your order."
      redirect_to post_path(@post) # Redirect back to the post page if something goes wrong
    end
  end

  # Display the user's orders
  def index
    @orders = current_user.orders # Fetch orders for the current user
  end

  private

  def order_params
    params.require(:order).permit(:message, :price_range) # Add any other order attributes
  end
end
