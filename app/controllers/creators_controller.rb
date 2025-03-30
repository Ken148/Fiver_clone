class CreatorsController < ApplicationController
  before_action :set_seller_profile, only: [:show]

  def show
    @gigs = @seller_profile.gigs.includes(:posts) if @seller_profile
  end

  private

  def set_seller_profile
    @seller_profile = SellerProfile.find_by(user_id: params[:id]) 
    unless @seller_profile
      redirect_to root_path, alert: "Seller profile not found"
    end
  end
end
