class AddAdmin < ActiveRecord::Migration
  def self.up
    add_column :people, :admin, :boolean, :default => false, :null => false
    add_column :people, :deactivated, :boolean, 
                        :default => false, :null => false
    person = Person.new(:email => "admin@example.com",
                        :name => "admin", 
                        :first_name => "user",
                        :name => "admin",
                        :password => "admin",
                        :password_confirmation => "admin",
                        :description => "")
    person.admin = true
    person.save!
    
    # Create the admin user
    # execute "INSERT INTO `people` (`email`, `name`, `first_name`, `crypted_password`, `state`, `description`, `admin`, `created_at`) VALUES('admin@coaliz.com', 'admin', 'user', 'ec8c99fc5e2905916dd5f467f1b6c522871b6dd3', 'active', '', 1, NOW())"
    
  end

  def self.down
    remove_column :people, :deactivated
    Person.delete(Person.find_by_name("admin"))
    remove_column :people, :admin
  end
end
