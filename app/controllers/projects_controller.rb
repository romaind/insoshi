class ProjectsController < ApplicationController
  
  before_filter :login_required, :only => [:edit, :update, :new, :create]
  before_filter :correct_user_required, :only => [:edit, :update, :new, :create]
  before_filter :setup
  
  # GET /projects
  # GET /projects.xml
  def index
    if params[:person_id]
      redirect_to person_path(params[:person_id])
    else
      @all_projects = Project.find(:all)
      @projects = Project.recent_to_older(params[:page])
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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
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
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = current_person.projects.create(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to person_project_path(current_person, @project) }
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
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to :back }
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
  
  private

  def setup
    @body = "project"
  end

  def correct_user_required
    redirect_to home_url unless Person.find(params[:person_id]) == current_person
  end
end
