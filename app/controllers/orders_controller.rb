class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: [:show, :reply]
  
    def index
      # Get all orders for the current creator (user)
      @orders = current_user.posts.joins(:orders).select('orders.*, posts.title').order('created_at DESC')
    end
  
    def show
      # Show the details of a specific order
    end
  
    def reply
      # Reply to the customer's order
      if @order.update(creator_reply: params[:creator_reply])
        redirect_to orders_path, notice: 'Your reply has been sent.'
      else
        render :show, alert: 'Something went wrong.'
      end
    end
  
    private
  
    def set_order
      @order = Order.find(params[:id])
    end
  end
  