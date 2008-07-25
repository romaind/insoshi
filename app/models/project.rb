class Project < ActiveRecord::Base
  belongs_to :person
  has_many :creations
end
