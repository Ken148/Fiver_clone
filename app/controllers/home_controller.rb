class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to posts_path and return  # Ensure redirect stops further execution
    end

    @posts = Post.all  # Fetch all posts to display on the homepage
  end
  def manifest
  end
end
