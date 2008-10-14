class CreateCreativeCommons < ActiveRecord::Migration
  def self.up
    create_table :creative_commons do |t|
      t.string :label
      t.timestamps
    end
    
    CreativeCommon.delete_all
    CreativeCommon.create( :label => "All rights reserved")
    CreativeCommon.create( :label => "Attribution")
    CreativeCommon.create( :label => "Attribution-Noncommercial")
    CreativeCommon.create( :label => "Attribution-Noncommercial-No Derivative Works")
    CreativeCommon.create( :label => "Attribution-Noncommercial-Share Alike")
    CreativeCommon.create( :label => "Attribution-No Derivative Works")
    CreativeCommon.create( :label => "Attribution-Share Alike")
    
    add_column :projects, :creative_common_id, :integer, :default => 1
  end

  def self.down
    drop_table :creative_commons
    
    remove_column :projects, :creative_common_id
  end
end
