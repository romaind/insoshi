class HomeController < ApplicationController
  skip_before_filter :require_activation
  
  def index
    @body = "home"
    @topics = Topic.find_recent
    @members = Person.find(:all)
    @projects = Project.recent_to_older(params[:page])
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
end
