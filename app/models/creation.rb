class Creation < ActiveRecord::Base
  belongs_to :project
  has_many :assets
end
