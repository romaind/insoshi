class AddStateColumnToPeople < ActiveRecord::Migration
  def self.up
    add_column      :people, :state, :string, :default => nil
  end

  def self.down
    remove_column     :people, :state
  end
end
