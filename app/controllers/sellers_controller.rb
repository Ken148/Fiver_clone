class SellersController < ApplicationController
  before_action :set_seller_profile, only: [:occupation_step, :update_occupation_step, :security_step, :update_security_step, :account, :update_account, :create_gig_step, :update_create_gig_step]

  def new
    @seller_profile = SellerProfile.new
  end

  def create
    @seller_profile = current_user.build_seller_profile(seller_profile_params)

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
      redirect_to create_gig_step_seller_path(@seller_profile), notice: "Security step completed!"
    else
      flash[:alert] = "Please fix the errors and try again!"
      render :security_step
    end
  end

  def create_gig_step
    # Render the create gig step form
  end

  def update_create_gig_step
    if @seller_profile.update(gig_creation_step_params)
      redirect_to account_seller_path(@seller_profile), notice: "Gig created! Now view your account."
    else
      flash[:alert] = "There was an error creating your gig."
      render :create_gig_step
    end
  end

  def account
    # This renders the account page where the seller can view and edit their profile info
  end

  def update_account
    if @seller_profile.update(account_params)
      redirect_to seller_account_path(@seller_profile), notice: "Profile updated successfully"
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

  def gig_creation_step_params
    # Add the required parameters for creating a gig here
    params.require(:seller_profile).permit(:gig_title, :gig_description, :gig_price)
  end
end
