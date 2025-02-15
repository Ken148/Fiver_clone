class SellerProfile < ApplicationRecord
    # Ensure validations for required fields
    validates :full_name, :display_name, :description, :language, presence: true
    validates :occupation, :skills, presence: true # Required fields
  
    def self.create_seller_profile(params)
        @seller_profile = SellerProfile.new(seller_profile_params(params))
      
        if @seller_profile.save
          # Redirect to the next page after profile creation
          redirect_to occupation_step_seller_path(@seller_profile) # Corrected path
        else
          render :new
        end
      end
      
  
    private
  
    def self.seller_profile_params(params)
      params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language, :occupation, :skills, :education, :certifications, :personal_website, :email, :phone_number)
    end
  end
  