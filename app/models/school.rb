class School < ActiveRecord::Base
  has_and_belongs_to_many :person
  has_many :people_schools
end
