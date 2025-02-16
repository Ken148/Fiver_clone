class SellersController < ApplicationController
  def new
    @seller_profile = SellerProfile.new
  end

  def create
    @seller_profile = SellerProfile.new(seller_profile_params)

    if @seller_profile.save
      flash[:notice] = "Profile saved! Now add your occupation and skills."
      redirect_to occupation_step_seller_path(@seller_profile) # Redirect to next step
    else
      Rails.logger.error("Failed to create seller profile: #{@seller_profile.errors.full_messages.join(', ')}")
      flash[:alert] = "Error: " + @seller_profile.errors.full_messages.join(', ')
      render :new
    end
  end

  def occupation_step
    @seller_profile = SellerProfile.find(params[:id])
  end

  def update_occupation_step
    @seller_profile = SellerProfile.find(params[:id])
  
    if @seller_profile.update(occupation_step_params)
      redirect_to security_step_seller_path(@seller_profile), notice: "Occupation step completed!"
    else
      flash[:alert] = "Please fill in all required fields!"
      render :occupation_step
    end
  end

  private

  def seller_profile_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
  end
  

  def occupation_step_params
    params.require(:seller_profile).permit(:occupation, :skills, :education, :certifications, :personal_website)
  end
end
