# NOTE: We use "comments" for both wall topic comments and blog comments,
# There is some trickery to handle the two in a unified manner.
class CommentsController < ApplicationController
  
  before_filter :login_required
  before_filter :get_instance_vars
  before_filter :authorize_destroy, :only => [:destroy]
  before_filter :connection_required

  # Used for both wall and blog comments.
  def new
    @comment = parent.comments.new

    respond_to do |format|
      format.html { render :action => resource_template("new") }
    end
  end

  # Used for both wall and blog comments.
  def create
    STDERR.puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    @comment = parent.comments.new(params[:comment].
                                   merge(:commenter => current_person))
    logger.info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + parent.email
    
    respond_to do |format|
      if @comment.save
        flash[:success] = 'Comment was successfully created.'
        format.html { redirect_to :back }
      else
        format.html { render :action => resource_template("new") }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      flash[:success] = "Comment deleted"
      format.html { redirect_to comments_url }
    end
  end
  
  private
  
    def get_instance_vars
      if project_wall?
        @project = Project.find(params[:project_id])
      elsif wall?
        @person = Person.find(params[:person_id])
      elsif blog?
        @blog = Blog.find(params[:blog_id])
        @post = Post.find(params[:post_id])
      end
    end
  
    def person
      @person || @blog.person
    end
    
    # Require the users to be connected.
    def connection_required
      if wall?
        unless connected_to?(person)
          flash[:notice] = "You must be contacts to complete that action"
          redirect_to @person
        end
      end
    end
    
    def authorize_destroy
      redirect_to home_url unless current_person?(person)
    end
    
    ## Handle wall and blog comments in a uniform manner.
    
    # Return the comments array for the given resource.
    def resource_comments
      if project_wall?
        @project.comments
      elsif wall?
        @person.comments
      elsif blog?
        @post.comments.paginate(:page => params[:page])
      end  
    end
    
    # Return a the parent (person or blog post) of the comment.
    def parent
      if project_wall?
        @project
      elsif wall?
        @person
      elsif blog?
        @post
      end
    end
    
    # Return the template for the current resource given the name.
    # For example, on a blog resource_template("new") gives "blog_new"
    def resource_template(name)
      "#{resource}_#{name}"
    end

    # Return a string for the resource.
    def resource
      if project_wall?
        "project_wall"
      elsif wall?
        "wall"
      elsif blog?
        "blog_post"
      end
    end
    
    # Return the URL for the resource comments.
    def comments_url
      if project_wall?
        @project
      elsif wall?
        @person
      elsif blog?
        blog_post_url(@blog, @post)
      end
    end

    # True if resource lives on a wall.
    def wall?
      !params[:person_id].nil?
    end

    def project_wall?
      !params[:project_id].nil?
    end

    # True if resource lives in a blog.
    def blog?
      !params[:blog_id].nil?
    end
end
