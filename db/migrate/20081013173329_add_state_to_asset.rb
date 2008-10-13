class AddStateToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :state, :string, :default => 'pending'
  end

  def self.down
    remove_column :assets, :state
  end
end