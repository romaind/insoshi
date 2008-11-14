class PeopleController < ApplicationController
 
  skip_before_filter :require_activation, :only => :verify_email
  skip_before_filter :must_be_active, :only => [:verify_email, :edit, :update ]
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
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = "That person is not active"
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @votes = 0
    @publishedprojects.each do |p|
      @votes += p.votes_for
      unless !p.views
        @views += p.views
      end
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
        if simple_captcha_valid? && @person.save
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
            format.html { redirect_to signup_path(:coupon => params[:person][:coupon]) }
          end
        else
          flash[:error] = 'Captcha not valid'
          format.html { redirect_to signup_path(:coupon => params[:person][:coupon]) }
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
      person.be_draft!
      self.current_person = person
      flash[:success] = "Email verified. Your profile is active! Please fill your personnal informations !!"
      redirect_to editprofile_path(person, "mandatory")
    end
  end

  def edit
    @part = params[:tab]
    
    @person = Person.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @person = Person.find(params[:id])
    
    respond_to do |format|
      case params[:type]
      when 'mandatory_edit'
        params[:person][:skill_ids] ||= []
        @country = Country.find(params[:person][:country_id])
        @person.origin_country = @country
        if !preview? and @person.update_attributes(params[:person])
          @person.be_active!
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(profile_path(@person, "profile")) }
        else
          if preview?
            @preview = @person.description = params[:person][:description]
          end
          format.html { render :action => "edit" }
        end
      when 'about_edit'
        if !preview? and @person.update_attributes(params[:person])
          @person.be_active!
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(profile_path(@person, "profile")) }
        else
          if preview?
            @preview = @person.description = params[:person][:description]
          end
          format.html { render :action => "edit" }
        end
      when 'skill_edit'
        params[:person][:language_ids] ||= []
        params[:person][:software_ids] ||= []
        
        # Schools handling
        # @person.schools.create!(:name => params[:person][:school_name])
        # ps = @person.people_schools.find(:first, :conditions => ["person_id = ?", @person.id])
        # schyear = params[:person]["school_year(1i)"]
        # ps.year = schyear.to_i
        # ps.save!
        # @person.school_attributes = params[:school]
        # End Schools handling
        @person.update_attributes(params[:person])
        @person.school_attributes = params[:person][:school_attributes]
        # @person.save!
        if !preview? and @person.save
          @person.be_active!
          flash[:success] = 'Profile updated!'
          # format.html { redirect_to(profile_path(@person, "profile")) }
          format.html { redirect_to editprofile_path(@person, "education") }
        else
          if preview?
            @preview = @person.description = params[:person][:description]
          end
          format.html { render :action => "edit" }
        end
      when "contact_edit"
        if !preview? and @person.update_attributes(params[:person])
          @person.be_active!
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(profile_path(@person, "profile")) }
        else
          if preview?
            @preview = @person.description = params[:person][:description]
          end
          format.html { render :action => "edit" }
        end
      when "notif_edit"
        if !preview? and @person.update_attributes(params[:person])
          @person.be_active!
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(profile_path(@person, "profile")) }
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
          format.html { redirect_to(profile_path(@person, "profile")) }
        else
          format.html { render :action => "edit" }
        end
      when 'project_edit'
        format.html { redirect_to editproject_path(current_person, params[:person][:projects], "settings") }
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
        flash[:success] = "Your beta_coupon is valid, now please register"
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
