class School < ActiveRecord::Base
  has_and_belongs_to_many :person
  has_many :people_schools
  
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end
  
end
