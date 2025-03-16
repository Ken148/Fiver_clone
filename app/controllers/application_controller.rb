class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_locale

  def set_language
    if params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale])
      session[:locale] = params[:locale]
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
