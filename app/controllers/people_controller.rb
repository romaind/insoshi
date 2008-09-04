class PeopleController < ApplicationController
 
  skip_before_filter :require_activation, :only => :verify_email
  skip_before_filter :admin_warning, :only => [ :show, :update ]
  skip_before_filter :require_login, :only => [ :coupon_validator, :verify_email]
  before_filter :login_required, :only => [ :edit, :update ]
  before_filter :correct_user_required, :only => [ :edit, :update ]
  before_filter :setup

  def index
    @people = Person.mostly_active(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def show
    @person = Person.find(params[:id])
    @projects = @person.projects.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC')
    unless @person.active? or current_person.admin?
      flash[:error] = "That person is not active"
      redirect_to home_url and return
    end
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects
    end
    respond_to do |format|
      format.html
    end
  end

  def new
    @body = "register single-col"
    @person = Person.new

    respond_to do |format|
      format.html
    end
  end

  def create
    cookies.delete :auth_token
    @person = Person.new(params[:person])
    respond_to do |format|
      @person.email_verified = false if global_prefs.email_verifications?
      if @betacoupon = BetaCoupon.find_by_coupon(params[:person][:coupon], :conditions => ["person_id is NULL"])
        if simple_captcha_valid? && 
          @person.save
          @betacoupon.person = @person
          @betacoupon.save
          if @person.errors.empty?
            if global_prefs.email_verifications?
              @person.email_verifications.create
              flash[:notice] = %(Thanks for signing up! A verification email has 
              been sent to #{@person.email}.)
              format.html { redirect_to new_session_path }
            else
              self.current_person = @person
              flash[:notice] = "Thanks for signing up!"
              format.html { redirect_back_or_default(home_url) }
            end
          else
            @body = "register single-col"
            format.html { render :action => 'new' }
          end
        else
          flash[:error] = 'Captcha not valid'
          format.html { render :action => 'new' }
        end
      else
        flash[:error] = 'Your coupon code is not valid'
        redirect_to home_url
      end
    end
  rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    redirect_to home_url
  end

  def verify_email
    verification = EmailVerification.find_by_code(params[:id])
    if verification.nil?
      flash[:error] = "Invalid email verification code"
      redirect_to home_url
    else
      cookies.delete :auth_token
      person = verification.person
      person.email_verified = true; person.save!
      person.be_active!
      self.current_person = person
      flash[:success] = "Email verified. Your profile is active! Please fill your personnal informations !!"
      redirect_to edit_person_path(person)
    end
  end

  def edit
    @person = Person.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    params[:person][:skill_ids] ||= []
    params[:person][:language_ids] ||= []
    params[:person][:software_ids] ||= []
    @person = Person.find(params[:id])
    
    respond_to do |format|
      case params[:type]
      when 'info_edit'
        @country = Country.find(params[:person][:country_id])
        @person.origin_country = @country
        if !preview? and @person.update_attributes(params[:person])
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(@person) }
        else
          if preview?
            @preview = @person.description = params[:person][:description]
          end
          format.html { render :action => "edit" }
        end
      when 'password_edit'
        if global_prefs.demo?
          flash[:error] = "Passwords can't be changed in demo mode."
          redirect_to @person and return
        end
        if @person.change_password?(params[:person])
          flash[:success] = 'Password changed.'
          format.html { redirect_to(@person) }
        else
          format.html { render :action => "edit" }
        end
      when 'project_edit'
        format.html { redirect_to edit_person_project_path(current_person, params[:person][:projects]) }
      end
    end
  end

  def common_contacts
    @person = Person.find(params[:id])
    @common_contacts = @person.common_contacts_with(current_person,
                                                          params[:page])
    respond_to do |format|
      format.html
    end
  end
  
  
  def password_changer
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  def coupon_validator
    if params[:invitation]
      STDERR.puts 'Coupooooooooon : ' + params[:invitation]
      if coupon = BetaCoupon.find_by_coupon(params[:invitation], :conditions => ["person_id is NULL"])
        flash[:error] = "Your beta_coupon is valid, now please loggin"
        redirect_to signup_path(:coupon => params[:invitation])
      else
        flash[:error] = "This beta coupon is not valid or already used"
        redirect_to new_session_path
      end
    else
      flash[:error] = "Please enter a beta coupon"
      redirect_to new_session_path
    end
  end
  
  private

  def setup
    @body = "person"
  end

  def correct_user_required
    redirect_to home_url unless Person.find(params[:id]) == current_person
  end

  def preview?
    params["commit"] == "Preview"
  end
end
