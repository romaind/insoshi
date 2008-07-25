class Asset < ActiveRecord::Base
  belongs_to :creation
  belongs_to :item, :polymorphic => true
end
