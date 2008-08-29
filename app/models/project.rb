class Project < ActiveRecord::Base
  NUM_WALL_COMMENTS = 10
  acts_as_taggable

  belongs_to :person
  has_many :creations, :dependent => :destroy
  has_and_belongs_to_many :skills
  has_many :comments, :as => :commentable, :order => 'created_at DESC',
                      :limit => NUM_WALL_COMMENTS
    
  class << self
    
    def recent_to_older(page = 1)
      paginate(:all, :page => page,
                     :per_page => RASTER_PER_PAGE,
                     :order => 'created_at DESC')
    end
    
  end
end
