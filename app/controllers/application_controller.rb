# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_locale
  #include ExceptionNotifiable
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user, :logged_in?
  

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  #为了安全，我们还用了filter_parameter_logging方法，把像password这样敏感的字段从日志中过滤掉，以防黑客偷窥到！

  def set_locale
    accept_lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    I18n.locale = params[:locale] || session[:locale] || accept_lang || 'zh'
    session[:locale] = I18n.locale
  end


end
