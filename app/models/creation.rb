class Creation < ActiveRecord::Base
  belongs_to :project
  has_one :asset, :as => :item, :dependent => :destroy

end
