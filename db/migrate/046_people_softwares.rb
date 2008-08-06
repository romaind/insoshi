class PeopleSoftwares < ActiveRecord::Migration
  def self.up
    create_table :people_softwares, :id => false, :force => true do |t|
      t.integer :person_id
      t.integer :software_id
    end
  end

  def self.down
    drop_table :people_softwares
  end
end
