class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.text :name

      t.timestamps
    end
  end

  def self.down
    drop_table :softwares
  end
end
