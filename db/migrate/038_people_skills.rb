class PeopleSkills < ActiveRecord::Migration
  def self.up
    create_table :people_skills, :id => false, :force => true do |t|
      t.integer :person_id
      t.integer :skill_id
    end
  end

  def self.down
    drop_table :people_skills
  end
end
