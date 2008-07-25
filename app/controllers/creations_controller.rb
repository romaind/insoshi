class CreationsController < ApplicationController
  
  before_filter :find_project, :only => [:index, :new, :edit, :create, :update, :show]
  
  # GET /creations
  # GET /creations.xml
  def index
    @creations = Creation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creations }
    end
  end

  # GET /creations/1
  # GET /creations/1.xml
  def show
    @creation = Creation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @creation }
    end
  end

  # GET /creations/new
  # GET /creations/new.xml
  def new
    @creation = Creation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creation }
    end
  end

  # GET /creations/1/edit
  def edit
    @creation = Creation.find(params[:id])
  end

  # POST /creations
  # POST /creations.xml
  def create
    @creation = @project.creations.create(params[:creation])

    respond_to do |format|
      if @creation.save
        flash[:notice] = 'Creation was successfully created.'
        format.html { redirect_to person_project_creation_path(current_person, @project, @creation) }
        format.xml  { render :xml => @creation, :status => :created, :location => @creation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @creation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /creations/1
  # PUT /creations/1.xml
  def update
    @creation = Creation.find(params[:id])

    respond_to do |format|
      if @creation.update_attributes(params[:creation])
        flash[:notice] = 'Creation was successfully updated.'
        format.html { redirect_to(@creation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @creation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /creations/1
  # DELETE /creations/1.xml
  def destroy
    @creation = Creation.find(params[:id])
    @creation.destroy

    respond_to do |format|
      format.html { redirect_to(person_project_creations_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_project
    @project = Project.find(params[:project_id])
  end
  
end
