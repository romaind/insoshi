class CreatePeopleSkills < ActiveRecord::Migration
  def self.up
    create_table :people_skills do |t|
      t.integer :person_id
      t.integer :skill_id
    end
  end

  def self.down
    drop_table :people_skills
  end
end
