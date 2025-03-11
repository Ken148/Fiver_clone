class SellersController < ApplicationController
  before_action :set_seller_profile, except: [:new, :create]

  def new
    @seller_profile = SellerProfile.new
  end

  def create
    current_user.seller_profile&.destroy  # Remove existing profile if any

    @seller_profile = current_user.build_seller_profile(seller_profile_params)

    if @seller_profile.save
      flash[:notice] = "Profile saved! Now add your occupation and skills."
      redirect_to occupation_step_seller_path(@seller_profile)
    else
      flash[:alert] = "Error: " + @seller_profile.errors.full_messages.join(', ')
      render :new
    end
  end

  def occupation_step
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
  end

  def update_security_step
    if @seller_profile.update(security_step_params)
      redirect_to account_seller_path(@seller_profile), notice: "Security step completed! Your profile is ready."
    else
      flash[:alert] = "Please fix the errors and try again!"
      render :security_step
    end
  end

  def account
    @gigs = @seller_profile.gigs
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
    return if action_name == 'new' || action_name == 'create'

    @seller_profile = current_user.seller_profile
    redirect_to new_seller_profile_path, alert: "You need to create a seller profile!" if @seller_profile.nil?
  end

  def seller_profile_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
  end

  def occupation_step_params
    params.require(:seller_profile).permit(:occupation, :start_year, :end_year, :skills, :education, :certifications, :personal_website)
  end

  def security_step_params
    params.require(:seller_profile).permit(:email, :phone_number, :country_code) # Include country_code here
  end

  def account_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language, occupation_ids: [], skill_ids: [], education_ids: [])
  end
end
