class SellersController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated
  before_action :set_seller_profile, except: [:new, :create]

  def new
    @seller_profile = SellerProfile.new
  end

  def create
    # Remove existing profile if any
    current_user.seller_profile&.destroy

    # Build a new seller profile for the logged-in user
    @seller_profile = current_user.build_seller_profile(seller_profile_params)

    # Validate profile before saving
    if validate_profile && @seller_profile.save
      flash[:notice] = "Profile saved! Now add your occupation and skills."
      redirect_to occupation_step_seller_path(@seller_profile)
    else
      flash[:alert] = "Error: " + @seller_profile.errors.full_messages.join(', ')
      render :new
    end
  end

  def occupation_step; end

  def update_occupation_step
    if @seller_profile.update(occupation_step_params)
      redirect_to security_step_seller_path(@seller_profile), notice: "Occupation step completed!"
    else
      flash[:alert] = "Please fill in all required fields!"
      render :occupation_step
    end
  end

  def security_step; end

  def update_security_step
    if @seller_profile.update(security_step_params)
      redirect_to account_seller_path(@seller_profile), notice: "Security step completed! Your profile is ready."
    else
      flash[:alert] = "Please fix the errors and try again!"
      render :security_step
    end
  end

  def account
    @gigs = @seller_profile.gigs.includes(:posts)
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

    unless @seller_profile
      redirect_to new_seller_profile_path, alert: "You need to create a seller profile first!"
    end
  end

  def validate_profile
    errors = []

    # Phone Number Validation (must be exactly 9 digits)
    if params[:seller_profile][:phone_number].present?
      phone_number = params[:seller_profile][:phone_number].gsub(/\D/, '')
      unless phone_number.length == 9
        errors << "Telefonska številka mora imeti točno 9 številk."
      end
    end

    # Start and End Year Validation
    if params[:seller_profile][:start_year].present? && params[:seller_profile][:end_year].present?
      start_year = params[:seller_profile][:start_year].to_i
      end_year = params[:seller_profile][:end_year].to_i
      if start_year > end_year
        params[:seller_profile][:end_year] = start_year
      end
    end

    if errors.any?
      flash[:alert] = errors.join(" ")
      return false
    end

    true
  end

  def seller_profile_params
    params.require(:seller_profile).permit(
      :full_name, :display_name, :profile_picture, :description, 
      :phone_number, :website, :start_year, :end_year, :occupation, :country_code,
      skill_ids: [], education_ids: []
    )
  end

  def occupation_step_params
    params.require(:seller_profile).permit(
      :occupation, :start_year, :end_year, :skills, :education, :certifications, :personal_website
    )
  end

  def security_step_params
    params.require(:seller_profile).permit(:phone_number, :country_code)
  end

  def account_params
    params.require(:seller_profile).permit(
      :full_name, :display_name, :profile_picture, :description, 
      :phone_number, :website, :start_year, :end_year, :occupation, :country_code,
      skill_ids: [], education_ids: []
    )
  end
end
