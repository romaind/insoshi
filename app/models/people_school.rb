class PeopleSchool < ActiveRecord::Base
  belongs_to :user, :foreign_key => "person_id", :class_name => "Person"
  belongs_to :school, :foreign_key => "school_id", :class_name => "School"
end