# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController

  skip_before_filter :require_activation, :only => [:new, :destroy]
  skip_before_filter :require_login, :only => [:new, :create]
  skip_before_filter :must_be_active
  layout "login"

  def new
    @body = "login single-col"
  end

  def create
    person = Person.authenticate(params[:email], params[:password])
    unless person.nil?
      if person.deactivated?
        flash[:error] = _("Your account has been deactivated")
        redirect_to home_url and return
      elsif global_prefs && global_prefs.email_verifications? and 
            not person.email_verified? and not person.admin?
        flash[:notice] = %(Unverified email address. 
                           Please check your email for your activation code.)
        redirect_to home_url and return
      end
    end
    self.current_person = person
    if logged_in?
      # First admin logins should forward to preferences
      if current_person.last_logged_in_at.nil? and current_person.admin?
        @first_admin_login = true
      end
      if current_person.activated?
        current_person.last_logged_in_at = Time.now
        current_person.save!
      end
      if params[:remember_me] == "1"
        self.current_person.remember_me
        cookies[:auth_token] = {
          :value => self.current_person.remember_token,
          :expires => self.current_person.remember_token_expires_at }
      end
      flash[:success] = _("Logged in successfully")
      if @first_admin_login
        redirect_to admin_preferences_url
      else
        redirect_back_or_default('/')
      end
    else
      @body = "login single-col"
      flash.now[:error] = _("Invalid email/password combination")
      params[:password] = nil
      render :action => 'new'
    end
  end

  def destroy
    self.current_person.forget_me if logged_in?
    cookies.delete :auth_token
    if logged_in? and current_person.deactivated?
      reset_session
      flash[:error] = _("Your account is inactive.")
      redirect_to home_url
    else
      reset_session
      flash[:success] = _("You have been logged out.")
      redirect_back_or_default(new_session_url)
    end
  end
end
