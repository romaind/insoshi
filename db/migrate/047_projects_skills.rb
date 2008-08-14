class ProjectsSkills < ActiveRecord::Migration
   def self.up
    create_table :projects_skills, :id => false, :force => true do |t|
      t.integer :project_id
      t.integer :skill_id
    end
  end

  def self.down
    drop_table :projects_skills
  end
end