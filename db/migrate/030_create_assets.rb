class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :creation_id
      t.string :item_content_type
      t.string :item_file_name
      t.integer :item_file_size
      t.integer :item_id
      t.string :item_type

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
