class CreationsController < ApplicationController
  
  before_filter :find_project, :only => [:index, :new, :edit, :create, :update, :show]
  before_filter :correct_project_owner_required, :except => [:show]
  
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
    @asset = Asset.create(params[:asset])
    
    @asset.item_content_type.starts_with?("video") ? jobs = Bj.submit("./script/runner ./jobs/convert_video_to_flv.rb #{@asset.id}", :rails_env => ENV['RAILS_ENV']) : @asset.is_picture!
    
    respond_to do |format|
      if @creation.save
        @creation.asset = @asset
        flash[:notice] = 'Creation was successfully created.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @creation, :status => :created, :location => @creation }
      else
        flash[:error] = "Please choose a file"
        format.html { redirect_to editproject_path(current_person, @project, "content") }
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
        format.html { redirect_to :back }
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
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_project
    @project = Project.find(params[:project_id])
  end
  
  private
  def correct_project_owner_required
    unless Project.find(params[:project_id]).person == current_person
      flash[:error] = "You're not allowed to access this area!"
      redirect_to person_path(current_person)
    end
  end
    
end
