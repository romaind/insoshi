class Country < ActiveRecord::Base
  has_many  :originating_person,
            :class_name => 'Person'
end
