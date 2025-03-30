class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Fetch all requests/orders for the logged-in user
    @requests = current_user.requests
  end
end
