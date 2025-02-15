class SellersController < ApplicationController
  # Initial information page
  def info
    # Info page logic (can display what being a seller is, etc.)
  end

  # New seller profile page
  def new
    @seller_profile = SellerProfile.new
  end

  # Creating the profile (first step)
  def create
    @seller_profile = SellerProfile.new(seller_profile_params)

    if @seller_profile.save
      # Redirect to the next step (occupation step)
      redirect_to occupation_step_seller_path(@seller_profile)
    else
      render :new
    end
  end

  # Occupation and skills step
  def occupation_step
    @seller_profile = SellerProfile.find(params[:id])
  end

  def update_occupation_step
    @seller_profile = SellerProfile.find(params[:id])
    
    if @seller_profile.update(occupation_step_params)
      redirect_to security_step_seller_path(@seller_profile)
    else
      render :occupation_step
    end
  end

  # Security step (email, phone, etc.)
  def security_step
    @seller_profile = SellerProfile.find(params[:id])
  end

  def update_security_step
    @seller_profile = SellerProfile.find(params[:id])
    
    if @seller_profile.update(security_step_params)
      redirect_to create_gig_step_seller_path(@seller_profile)
    else
      render :security_step
    end
  end

  # Final step to create a gig (for now placeholder)
  def create_gig_step
    @seller_profile = SellerProfile.find(params[:id])
    # Gig creation logic here
  end

  private

  # Strong parameters for creating the initial profile (full name, display name, etc.)
  def seller_profile_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
  end

  # Strong parameters for occupation and skills step
  def occupation_step_params
    params.require(:seller_profile).permit(:occupation, :skills, :education, :certifications, :personal_website)
  end

  # Strong parameters for security step (email, phone, etc.)
  def security_step_params
    params.require(:seller_profile).permit(:email, :phone_number)
  end
end
