# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  include SharedHelper
  include PreferencesHelper
  include SimpleCaptcha::ControllerHelpers
  
  before_filter :create_page_view, :require_activation, :tracker_vars,
                :admin_warning,
                :require_login,
                :must_be_active
                
  # I18N with gettext http://www.yotabanana.com/hiki/ruby-gettext-howto-rails.html
  before_init_gettext :default_locale
  def default_locale
    default_locale = 'en'
      request_language = request.env['HTTP_ACCEPT_LANGUAGE']
      request_language = request_language.nil? ? nil : request_language[/[^,;]+/]

      # non supported languages should default to english actually
      unless ["fr", "en"].include? request_language
        request_language = default_locale
      end

      @locale = params[:lang] || session[:lang] ||
                request_language || default_locale
      # If the user sends a locale in the params, it means he wants to change of it so it has to be stored
      if logged_in? && params[:lang]
        current_user.update_attribute(:language, params[:lang])
      end

      session[:lang] = @locale
      begin
        set_locale @locale
      rescue
        set_locale default_locale
      end
  end 
  init_gettext "coaliz"

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '71a8c82e6d248750397d166001c5e308'

  def require_login
    unless logged_in? or BetaCoupon.find_by_coupon(params[:coupon], :conditions => ["person_id is NULL"]) or (params[:person] && BetaCoupon.find_by_coupon(params[:person][:coupon], :conditions => ["person_id is NULL"]))
      redirect_to new_session_url
    end
  end

  private

    def admin_required
      unless current_person.admin?
        flash[:error] = _("Admin access required")
        redirect_to home_url
      end
    end
  
    # Create a Scribd-style PageView.
    # See http://www.scribd.com/doc/49575/Scaling-Rails-Presentation
    def create_page_view
      PageView.create(:person_id => session[:person_id],
                      :request_url => request.request_uri,
                      :ip_address => request.remote_ip,
                      :referer => request.env["HTTP_REFERER"],
                      :user_agent => request.env["HTTP_USER_AGENT"])
      if logged_in?
        # last_logged_in_at actually captures site activity, so update it now.
        current_person.last_logged_in_at = Time.now
        current_person.save
      end
    end
  
    def require_activation
      if logged_in?
        unless current_person.active? or current_person.admin?
          redirect_to logout_url
        end
      end
    end
    
    # A tracker to tell us about the activity of Insoshi installs.
    def tracker_vars
      File.open("identifier", "w") do |f|
        f.write UUID.new
      end unless File.exist?("identifier")
      @tracker_id = File.open("identifier").read rescue nil
      @env = ENV['RAILS_ENV']
    end
    
    # Warn the admin if his email address or password is still the default.
    def admin_warning
      default_domain = "example.com"
      default_password = "admin"
      if logged_in? and current_person.admin? 
        if current_person.email =~ /@#{default_domain}$/
          flash[:notice] = %(Warning: your email address is still at 
            #{default_domain}.
            <a href="#{edit_person_path(current_person)}">Change it here</a>.)
        end
        if current_person.unencrypted_password == default_password
          flash[:error] = %(Warning: your password is still the default.
            <a href="#{edit_person_path(current_person)}">Change it here</a>.)          
        end
      end
    end
    
    def must_be_active
      if logged_in?
        unless current_person.activated?
          flash[:error] = _("Please fill your personal informations")
          redirect_to editprofile_path(current_person, "mandatory")
        end
      end
    end
    
    def must_be_a_published_project
      if logged_in?
        unless Project.find(params[:id]).published? or Project.find(params[:id]).person_id == current_person.id
          flash[:error] = _("You're not allowed to access this project")
          redirect_to home_url
        end
      end
    end
    
end