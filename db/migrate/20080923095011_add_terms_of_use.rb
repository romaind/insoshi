class AddTermsOfUse < ActiveRecord::Migration
  def self.up
    add_column :people, :terms_of_use, :boolean, :default => false
  end

  def self.down
    remove_column :people, :terms_of_use
  end
end
