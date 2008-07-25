class Asset < ActiveRecord::Base
  include ActivityLogger
  
  UPLOAD_LIMIT = 5 # megabytes
  
  belongs_to :item, :polymorphic => true
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => UPLOAD_LIMIT.megabytes,
                 :min_size => 1,
                 :resize_to => '240>',
                 :thumbnails => { :thumbnail    => '72>',
                                  :icon         => '36>',
                                  :bounded_icon => '36x36>' }
  
end
