class BetaCoupon < ActiveRecord::Base
  belongs_to :person
  
  # coupon is needed but we create it automatically before the validation
  validates_presence_of     :coupon
  validates_uniqueness_of   :coupon, :on => :create

end
