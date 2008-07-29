require 'paperclip'
class Asset < ActiveRecord::Base
  # belongs_to :creation
  belongs_to :item, :polymorphic => true
  
  # validates_attachment_presence :item
  
  # Paperclip
  has_attached_file :item,
    :styles => {
      :tiny   => "48x48#",
      :thumb  => "72x72#",
      :small  => "150x150>" }
  
end
