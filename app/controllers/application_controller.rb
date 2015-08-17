require 'bh-flash'

# application controller
class ApplicationController < ActionController::Base
  helper Bh::Flash

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from TranslationCache::CacheError do |ex|
    logger.error(ex)
    flash.now[:alert] = "Failed to save translation in the cache: #{ex}"
    render action: action_name
  end

  protected

  def default_url_options
    # only_path: false will force path helpers (explicit and implicit) to generate URLs
    @url_options ||= Rails.env.test? || Rails.env.development? || !request.ssl? ? {} : { protocol: 'https', only_path: false }
  end
end
