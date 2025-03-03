class SellersController < ApplicationController
  before_action :set_seller_profile, only: [:occupation_step, :update_occupation_step, :security_step, :update_security_step, :account, :update_account, :create_gig_step, :update_create_gig_step]

  def create
    # Check if the current user already has a seller profile
    if current_user.seller_profile.present?
      # If the user already has a profile, update it with new data
      @seller_profile = current_user.seller_profile
      if @seller_profile.update(seller_profile_params)
        flash[:notice] = "Your profile has been updated."
        redirect_to seller_account_path(@seller_profile) # Redirect to the account page or another page as needed
        return
      else
        flash[:alert] = "There was an error updating your profile."
        render :new # Render the new form to correct any issues
        return
      end
    end

    # If no existing profile, create a new seller profile for the user
    @seller_profile = current_user.build_seller_profile(seller_profile_params)

    if @seller_profile.save
      flash[:notice] = "Profile saved! Now add your occupation and skills."
      redirect_to occupation_step_seller_path(@seller_profile) # Redirect to the next step
    else
      flash[:alert] = "Error: " + @seller_profile.errors.full_messages.join(', ')
      render :new # If the profile could not be created, render the 'new' form again
    end
  end

  private

  def seller_profile_params
    params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
  end
end
