class CreateBetaCoupons < ActiveRecord::Migration
  def self.up
    create_table :beta_coupons do |t|
      t.string :coupon
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_coupons
  end
end
