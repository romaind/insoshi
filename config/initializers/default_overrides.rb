# This overrides the :per_page attribute for will_paginate.
# The default for will_paginate is 30, which seems a little high.
class ActiveRecord::Base
  def self.per_page
    10
  end
end

unless '1.9'.respond_to?(:force_encoding)
  String.class_eval do
    begin
      remove_method :chars
    rescue NameError
      # OK
    end
  end
end