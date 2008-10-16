class AddDefaultToProjectViews < ActiveRecord::Migration
  def self.up
    change_column :projects, :views, :integer, :default => 0
  end

  def self.down
    change_column :projects, :views, :integer
  end
end
