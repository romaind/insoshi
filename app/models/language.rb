class Language < ActiveRecord::Base
  has_and_belongs_to_many :person
end