class SellersController < ApplicationController
  # No longer restricting to specific actions with :only
  before_action :set_seller_profile

  def new
    @seller_profile = SellerProfile.new
  end

  def create
    existing_profile = current_user.seller_profile
    if existing_profile
      existing_profile.destroy
    end

    @seller_profile = current_user.build_seller_profile(seller_profile_params)

    Rails.logger.debug("Seller Profile Params: #{seller_profile_params.inspect}")  # Debugging the incoming parameters

    if @seller_profile.save
      flash[:notice] = "Profile saved! Now add your occupation and skills."
      redirect_to occupation_step_seller_path(@seller_profile)
    else
      Rails.logger.error("Failed to create seller profile: #{@seller_profile.errors.full_messages.join(', ')}")
      flash[:alert] = "Error: " + @seller_profile.errors.full_messages.join(', ')
      render :new
    end
  end

  def occupation_step
    # Render the occupation step form
  end

  def update_occupation_step
    if @seller_profile.update(occupation_step_params)
      redirect_to security_step_seller_path(@seller_profile), notice: "Occupation step completed!"
    else
      flash[:alert] = "Please fill in all required fields!"
      render :occupation_step
    end
  end

  def security_step
    # Render the security step form
  end

  def update_security_step
    if @seller_profile.update(security_step_params)
      # Instead of redirecting to the gig creation step, we redirect to the account page.
      redirect_to account_seller_path(@seller_profile), notice: "Security step completed! Your profile is ready."
    else
      flash[:alert] = "Please fix the errors and try again!"
      render :security_step
    end
  end

  # The account page where the seller can view and edit their profile
  def account
    # Assuming that there's a 'has_many :gigs' relationship in SellerProfile
    @gigs = @seller_profile.gigs  # Only works if SellerProfile has many Gigs
  end

  def update_account
    if @seller_profile.update(account_params)
      redirect_to account_seller_path(@seller_profile), notice: "Profile updated successfully"
    else
      flash[:alert] = "There was an error updating your profile!"
      render :account
    end
  end

  private

  def set_seller_profile
    @seller_profile = current_user.seller_profile
    if @seller_profile.nil?
      redirect_to new_seller_profile_path, alert: "You need to create a seller profile!"
    end
  end

  def seller_profile_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
  end

  def occupation_step_params
    params.require(:seller_profile).permit(:occupation, :start_year, :end_year, :skills, :education, :certifications, :personal_website)
  end

  def security_step_params
    params.require(:seller_profile).permit(:email, :password, :password_confirmation)
  end

  def account_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language, occupation_ids: [], skill_ids: [], education_ids: [])
  end
end
