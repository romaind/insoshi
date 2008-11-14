class MessagesController < ApplicationController

  before_filter :login_required, :setup
  before_filter :authenticate_person, :only => [:show]
  before_filter :handle_cancel, :only => [:create]
  before_filter :validate_reply, :only => [:create]

  # GET /messages
  def index
    @messages = current_person.received_messages(params[:page])
    
    @person = Person.find(params[:person_id])
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = _("That person is not active")
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @publishedprojects.each do |p|
      unless !p.views
        @views += p.views
      end
    end
    
    respond_to do |format|
      format.html { render :template => "messages/index" }
    end
  end

  # GET /messages/sent
  def sent
    @messages = current_person.sent_messages(params[:page])
    
    @person = Person.find(params[:person_id])
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = _("That person is not active")
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @publishedprojects.each do |p|
      unless !p.views
        @views += p.views
      end
    end
    
    respond_to do |format|
      format.html { render :template => "messages/index" }
    end
  end
  
  # GET /messages/trash
  def trash
    @messages = current_person.trashed_messages(params[:page])
    
    @person = Person.find(params[:person_id])
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = _("That person is not active")
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @publishedprojects.each do |p|
      unless !p.views
        @views += p.views
      end
    end
    
    respond_to do |format|
      format.html { render :template => "messages/index" }
    end    
  end

  def show
    @message.mark_as_read if current_person?(@message.recipient)
    if @message.parent_id.nil?
      subject_id = @message.id
    else
      subject_id = @message.parent_id
    end
    @talks = current_person.discussion(subject_id)
    
    @person = Person.find(params[:person_id])
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = _("That person is not active")
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @publishedprojects.each do |p|
      unless !p.views
        @views += p.views
      end
    end
    
    respond_to do |format|
      format.html
    end
  end

  def new    
    @message = Message.new
    if params[:person_id].nil?
      @recipient = current_person
    else
      @recipient = Person.find(params[:person_id])
    end
    
    @person = Person.find(params[:person_id])
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = _("That person is not active")
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @publishedprojects.each do |p|
      unless !p.views
        @views += p.views
      end
    end

    respond_to do |format|
      format.html
    end
  end

  def reply
    original_message = Message.find(params[:id])
    subject = original_message.subject
    unless original_message.subject.include?("RE:")
      subject = "RE:" + original_message.subject
    end
    parent_id = original_message.parent_id
    if original_message.parent_id.nil?
      parent_id = original_message.id
    end
    @message = Message.new(:parent_id => parent_id,
                           :subject => subject,
                           :sender => current_person,
                           :recipient => original_message.sender)
    @recipient = not_current_person(original_message)
    
    @person = Person.find(params[:person_id])
    
    @publishedprojects = @person.projects.all_published
    @publishedprojects = @person.projects.all_published.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @publishedprojects.size > 0
      
    @draftprojects = @person.projects.all_draft
    @draftprojects = @person.projects.all_draft.paginate(:page => params[:page], :per_page => 12, :order => 'created_at DESC') if @draftprojects.size > 0
    
    unless @person.active? or current_person.admin?
      flash[:error] = _("That person is not active")
      redirect_to home_url and return
    end
    
    if logged_in?
      @some_contacts = @person.some_contacts
      @common_contacts = current_person.common_contacts_with(@person)
      @person_projects = @person.projects.all_published
    end
    
    @views = 0
    @publishedprojects.each do |p|
      unless !p.views
        @views += p.views
      end
    end    
    
    respond_to do |format|
      format.html { render :action => "new" }
    end    
  end

  def create
    if params["commit"] == "Send to all" and current_person.admin?
      # Send messages to all (active) people.
      messages = Person.all_active.inject([]) do |messages, person|
        message = Message.new(params[:message].merge(:sender => current_person,
                                                     :recipient => person))
        messages.push(message)
      end
      respond_to do |format|
        @message = messages.first
        if !preview? and @message.save
          messages.each { |m| m.save }
          flash[:success] = 'Message sent to everyone!'
          format.html { redirect_to person_messages_url(current_person) }
        else
          @preview = @message.content if preview?
          format.html { render :action => "new" }
        end
      end
    else
      if params[:message]['recipient']
        @recipient = Person.find(params[:message]['recipient'])
      end
      
      @message = Message.new(params[:message].merge(:sender => current_person,
                                                    :recipient => @recipient))
    
      respond_to do |format|
        if !preview? and @message.save
          flash[:success] = 'Message sent!'
          format.html { redirect_to person_messages_url(current_person) }
        else
          @preview = @message.content if preview?
          format.html { render :action => "new" }
        end
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.trash(current_person)
      flash[:success] = _("Message trashed")
    else
      # This should never happen...
      flash[:error] = _("Invalid action")
    end
  
    respond_to do |format|
      format.html { redirect_to person_messages_url(current_person) }
    end
  end
  
  def undestroy
    @message = Message.find(params[:id])
    if @message.untrash(current_person)
      flash[:success] = _("Message restored to inbox")
    else
      # This should never happen...
      flash[:error] = _("Invalid action")
    end
    respond_to do |format|
      format.html { redirect_to messages_url }
    end
  end

  private
  
    def setup
      @body = "messages"
    end
  
    def authenticate_person
      @message = Message.find(params[:id])
      unless (current_person == @message.sender or
              current_person == @message.recipient)
        redirect_to login_url
      end
    end

    def handle_cancel
      redirect_to messages_url if params[:commit] == "Cancel"
    end
    
    def validate_reply
      @recipient = Person.find(params[:person_id])
      redirect_to home_url if reply? and not valid_reply?(@recipient)
    end
    
    def reply?
      !params[:parent_id].nil?
    end

    def valid_reply?(recipient)
      original = Message.find(params[:parent_id])
      original.recipient == current_person and original.sender == recipient
    end
    
    # Return the proper recipient for a message.
    # This should not be the current person in order to allow multiple replies
    # to the same message.
    def not_current_person(message)
      message.sender == current_person ? message.recipient : message.sender
    end

    def preview?
      params["commit"] == "Preview"
    end

end
