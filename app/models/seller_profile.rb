class SellerProfile < ApplicationRecord
    validates :full_name, :display_name, :description, :language, presence: true
    validates :occupation, :skills, presence: true # Required fields
    def info
        # Info page logic
      end
    
      def new
        @seller_profile = SellerProfile.new
      end
    
      def create
        @seller_profile = SellerProfile.new(seller_profile_params)
        
        if @seller_profile.save
          # Redirect to the next page after profile creation
          redirect_to next_page_path # Replace with your next page path
        else
          render :new
        end
      end
    
      private
    
      def seller_profile_params
        params.require(:seller_profile).permit(:full_name, :display_name, :profile_picture, :description, :language)
      end
end
