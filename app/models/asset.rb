require 'paperclip'
class Asset < ActiveRecord::Base
  # belongs_to :creation
  belongs_to :item, :polymorphic => true
  
  # validates_attachment_presence :item
  
  # Paperclip
  has_attached_file :item,
    :styles => {
      :tiny   => "90x90#",
      :thumb  => "57x57#",
      :small  => "130x90#",
      :preview => "188x145#" }
  
end
