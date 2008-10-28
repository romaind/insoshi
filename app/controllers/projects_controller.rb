class ProjectsController < ApplicationController

  before_filter :login_required, :only => [:edit, :update, :new, :create]
  before_filter :correct_user_required, :only => [:edit, :update, :new, :create]
  before_filter :correct_project_required, :only => [:edit, :update]
  before_filter :find_project, :only => [:show]
  before_filter :must_be_a_published_project, :only => [:show]
  before_filter :setup
  
  # GET /projects
  # GET /projects.xml
  def index
    if params[:person_id]
      redirect_to person_path(params[:person_id])
    else
      @all_projects = Project.all_published.paginate(:page => params[:author_page],:per_page => 5, :order => 'created_at DESC')
      @projects = Project.published_recent_to_older(params[:page])
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @all_projects }
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @author = @project.person
    @author_projects = @author.projects.all_published.paginate(:page => params[:author_page],:per_page => 5, :order => 'created_at DESC')
    @all_projects = Project.all_published.paginate(:page => params[:all_page], :per_page => 5)
    @canvote = true
    if Vote.find_by_voteable_id_and_voteable_type_and_voter_id(@project.id, "Project", current_person.id)
      @canvote = false
    end

    respond_to do |format|
      format.html {
        if !current_person?(@project.person)
          @project.update_attributes(:views => @project.views+1)
        end
      }# show.html.erb
      format.xml
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @creation = Creation.new
    if params[:tab]
      @part = params[:tab]
    else
      @part = "settings"
    end
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = current_person.projects.create(params[:project])

    respond_to do |format|
      if @project.save
        # if params[:project][:state] == 'draft' && !@project.draft?
        #   @project.be_draft!
        # elsif params[:project][:state] == 'published' && !@project.published?
        #   @project.publish!
        # end
        if params[:project][:state] == 'published'
          flash[:error] = "Please upload your creations in this project before publishing it!"
        end
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to editproject_path(current_person, @project, "content") }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    unless params[:project][:creative_common_id]
      params[:project][:skill_ids] ||= []
    end
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        if params[:project][:state] == 'draft' && !@project.draft?
          @project.be_draft!
        elsif params[:project][:state] == 'published' && !@project.published? && @project.creations.length == 0
          flash[:error] = "You can't publish a project without a creation"
        elsif params[:project][:state] == 'published' && !@project.published?
          @project.publish!
        end
        flash[:notice] = 'Project was successfully updated.'
        format.html {
          if params[:project][:creative_common_id]
            redirect_to editproject_path(current_person, @project, "copyrights")
          else
            redirect_to editproject_path(current_person, @project, "content")
          end
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to person_projects_url }
      format.xml  { head :ok }
    end
  end
  
  def choose
    
  end
  
  def vote
    project = Project.find(params[:id])
    if Vote.find_by_voteable_id_and_voteable_type_and_voter_id(project.id, "Project", current_person.id)
      message = "You've already voted for this project"
    else
      current_person.vote_for(project)
      message = "Thank you for your vote"
    end
    
    respond_to do |format|
      format.html { 
        flash[:notice] = message
        redirect_to person_project_path(project.person, project)
        }
    end
  end
  
  def cc_detail
    case params[:id]
    when "1"
      # render :partial => "projects/commons/attribution.html.erb"
      render :text => "You reserve all property of this work"
    when "2"
      render :partial => "projects/commons/attribution.html.erb"
    when "3"
      render :partial => "projects/commons/attribution_nocommercial.html.erb"
    when "4"
      render :partial => "projects/commons/attribution_nocommercial_noderivative.html.erb"
    when "5"
      render :partial => "projects/commons/attribution_nocommercial_sharealike.html.erb"
    when "6"
      render :partial => "projects/commons/attribution_noderivative.html.erb"
    when "7"
      render :partial => "projects/commons/attribution_sharealike.html.erb"
    end
  end
  
  def publish
    project = Project.find(params[:id])
    project.publish!
    
    respond_to do |format|
      format.html {
        flash[:notice] = "Your project has been published"
        redirect_to profile_path(current_person, "profile")
      }
    end
    
    
  end
  
  private

  def setup
    @body = "project"
  end
  
  def find_project
    if params[:id]
      @project = Project.find(params[:id])
    end
  end

  def correct_user_required
    unless Person.find(params[:person_id]) == current_person
      flash[:error] = "You're not allowed to access this area!"
      redirect_to person_path(current_person) 
    end
  end
  
  def correct_project_required
    unless Project.find(params[:id]).person_id == current_person.id
      flash[:error] = "You're not allowed to access this area!"
      redirect_to person_project_path(params[:person_id], params[:id])
    end
  end
  
end
