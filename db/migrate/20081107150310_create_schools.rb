class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :people_schools do |t|
      t.integer :person_id
      t.integer :school_id
      t.integer :year
    end
  end

  def self.down
    drop_table :schools
    drop_table :people_schools
  end
end
