class CreateCreations < ActiveRecord::Migration
  def self.up
    create_table :creations do |t|
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :creations
  end
end
