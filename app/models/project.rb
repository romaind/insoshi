class Project < ActiveRecord::Base
  belongs_to :person
  has_many :creations, :dependent => :destroy
end
