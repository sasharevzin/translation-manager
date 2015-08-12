require 'bh-flash'

# application controller
class ApplicationController < ActionController::Base
  helper Bh::Flash

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl if: :ssl_configured?

  rescue_from TranslationCache::CacheError do |ex|
    logger.error(ex)
    flash.now[:alert] = "Failed to save translation in the cache: #{ex}"
    render action: action_name
  end

  private

  def ssl_configured?
    !Rails.env.development? && !Rails.env.test?
  end
end
