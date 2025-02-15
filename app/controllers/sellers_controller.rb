class SellersController < ApplicationController
  def info
    # Info page logic
  end

  def new
    @seller_profile = SellerProfile.new
  end

  def create
    @seller_profile = SellerProfile.new(seller_profile_params)
    
    if @seller_profile.save
      # Redirect to the next page
      redirect_to next_page_path
    else
      render :new
    end
  end

  private

  def seller_profile_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
  end
end
