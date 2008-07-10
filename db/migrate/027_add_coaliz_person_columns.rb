class AddCoalizPersonColumns < ActiveRecord::Migration
  def self.up
    rename_column   :people, :name, :last_name
    add_column      :people, :first_name, :string, :default => nil
    #add_column      :people, :area, :string, :default => nil
    #add_column      :people, :stars, :string, :default => nil
    add_column      :people, :gender, :integer, :default => nil
    add_column      :people, :birthdate, :date, :default => nil
    #add_column      :people, :role, :integer, :default => 0
    add_column      :people, :address, :string, :default => nil
    add_column      :people, :zipcode, :string, :default => nil
    add_column      :people, :city, :string, :default => nil
    #add_column      :people, :country, :integer, :default => nil # how does it work in rails ?
    add_column      :people, :phone, :string, :default => nil
    add_column      :people, :website, :string, :default => nil
    add_column      :people, :cv, :string, :default => nil
    #add_column      :people, :sponsor, :string, :default => nil
  end

  def self.down
    remove_column     :people, :first_name
    rename_column     :people, :last_name, :name
    #remove_column    :people, :area
    #remove_column    :people, :stars
    remove_column     :people, :gender
    remove_column     :people, :birthdate
    #remove_column    :people, :role
    remove_column     :people, :address
    remove_column     :people, :zipcode
    remove_column     :people, :city
    #remove_column    :people, :country
    remove_column     :people, :phone
    remove_column     :people, :website
    remove_column     :people, :cv
    #remove_column    :people, :sponsor
  end
end
