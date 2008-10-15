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
      @all_projects = Project.all_published
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


    respond_to do |format|
      format.html {
        if !@project.views
          @project.update_attributes(:views => 0)
        end
        @project.update_attributes(:views => @project.views+1)
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
    params[:project][:skill_ids] ||= []
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        if params[:project][:state] == 'draft' && !@project.draft?
          @project.be_draft!
        elsif params[:project][:state] == 'published' && !@project.published?
          @project.publish!
        end
        flash[:notice] = 'Project was successfully updated.'
        format.html { 
          if params[:project][:creative_common_id]
            redirect_to editproject_path(current_person, @project, "copyrights")
          else
            redirect_to person_project_path(current_person, @project)
          end }
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
