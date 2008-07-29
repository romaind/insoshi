class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :views
      t.integer :person_id
      t.text :licence

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
