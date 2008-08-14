class Skill < ActiveRecord::Base
  has_and_belongs_to_many :person
  has_and_belongs_to_many :project
end
