class HomeController < ApplicationController
  skip_before_filter :require_activation
  skip_before_filter :must_be_active, :only => [:terms ]

  def index
    @body = "home"
    @topics = Topic.find_recent
    @members = Person.find(:all)
    @projects = Project.published_recent_to_older(params[:page])
    @project = @projects.first
    
    if logged_in?
      @feed = current_person.feed
      @some_contacts = current_person.some_contacts
      @requested_contacts = current_person.requested_contacts
    else
      @feed = Activity.global_feed
    end    
    respond_to do |format|
      format.html
    end  
  end
  
  def requested_contacts
    if logged_in?
      @requested_contacts = current_person.requested_contacts
    end
  end
  
  def feedback
    if params[:feedback] && params[:feedback][:message]
      PersonMailer.deliver_feedback(current_person, params[:feedback][:message])
    end
    
    respond_to do |format|
      format.html {
        flash[:notice] = "Your message has been sent. Thank you"
        redirect_to '/'}
    end
  end
  
  def abuse
    render :layout => false
  end
  
  def contact_us
    if request.post?
      if !params[:contact][:email].blank? && !params[:contact][:message].blank?
        PersonMailer.deliver_contact(params[:contact][:email], params[:contact][:message])
        respond_to do |format|
          format.html {
            flash[:notice] = "Your message has been sent. Thank you"
            redirect_to home_path
          }
        end
      else
        respond_to do |format|
          format.html {
            flash[:error] = "Email and Message can't be blank"
            redirect_to :back
          }
        end
      end
      
    end
  end
  
  def send_abuse
    if params[:item] == "project"
      item = Project.find(params[:id])
    end
    if params[:abuse] && params[:abuse][:message]
      PersonMailer.deliver_abuse(params[:abuse][:email], params[:abuse][:message])
    end
    respond_to do |format|
      format.html {
        flash[:notice] = "Your message has been sent. Thank you"
        redirect_to person_project_path(item.person, item)
      }
    end
  end
  
  def terms
    
  end
  
end
