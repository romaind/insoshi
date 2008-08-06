class LanguagesPeople < ActiveRecord::Migration
  def self.up
    create_table :languages_people, :id => false, :force => true do |t|
      t.integer :person_id
      t.integer :language_id
    end
  end

  def self.down
    drop_table :languages_people
  end
end
