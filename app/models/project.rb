class Project < ActiveRecord::Base
  include ActionView::Helpers::AssetTagHelper
  
  validates_presence_of :title
  validates_presence_of :skills
  
  # attr_accessor :status
  attr_protected :state
  
  NUM_WALL_COMMENTS = 10
  acts_as_taggable

  acts_as_state_machine :initial => :draft
  state :draft
  state :published
  
  event :publish do
    transitions :to => :published, :from => :draft
  end
  
  event :be_draft do
    transitions :to => :draft, :from => :published
  end

  belongs_to :person
  belongs_to :common,
             :class_name => 'CreativeCommon',
             :foreign_key => :creative_common_id
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
    
    def published_recent_to_older(page = 1)
      paginate(:all, :page => page,
                     :per_page => RASTER_PER_PAGE,
                     :order => 'created_at DESC',
                     :conditions => conditions_for_published)
    end
    
    def all_published
      find_in_state(:all, :published)
    end
    
    def all_draft
      find_in_state(:all, :draft)
    end
    
  end
  
  protected
  
  def self.conditions_for_published
    [%(state = 'published')]
  end
  
end
