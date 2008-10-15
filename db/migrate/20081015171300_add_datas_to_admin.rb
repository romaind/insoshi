class AddDatasToAdmin < ActiveRecord::Migration
  def self.up
    admin = Person.find(1)
    
    admin.gender = 1
    admin.terms_of_use = true
    admin.birthdate = '1980-01-01'
    admin.skills << Skill.find(1)
    admin.be_draft!
    admin.be_active!
    
    admin.save
  end

  def self.down
  end
end
