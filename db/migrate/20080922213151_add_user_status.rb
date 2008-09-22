class AddUserStatus < ActiveRecord::Migration
  def self.up
    add_column :people, :status, :string
  end

  def self.down
    remove_column :people, :status
  end
end
