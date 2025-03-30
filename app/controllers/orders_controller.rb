class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = current_user.requests  # Fetch all requests for the logged-in user
  end
end
