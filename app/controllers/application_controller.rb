class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_seller_profile, if: :user_signed_in? # ✅ Ensure seller profile is set

  def set_language
    if params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale])
      session[:locale] = params[:locale]
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  # ✅ Set seller profile globally for all views
  def set_seller_profile
    @seller_profile = current_user.seller_profile
  end
end
