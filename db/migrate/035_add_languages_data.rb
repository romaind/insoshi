class AddLanguagesData < ActiveRecord::Migration
  def self.up
    Language.delete_all
    Language.create(:name => "Arabic")
 	  Language.create(:name => "Catalan")
 	  Language.create(:name => "Chinese")
 	  Language.create(:name => "Czech")
 	  Language.create(:name => "Danish")
 	  Language.create(:name => "Dutch")
 	  Language.create(:name => "English")
 	  Language.create(:name => "Finnish")
 	  Language.create(:name => "French")
 	  Language.create(:name => "German")
 	  Language.create(:name => "Greek")
 	  Language.create(:name => "Hebrew")
 	  Language.create(:name => "Hungarian")
 	  Language.create(:name => "Icelandic")
 	  Language.create(:name => "Italian")
 	  Language.create(:name => "Japanese")
 	  Language.create(:name => "Korean")
 	  Language.create(:name => "Malay")
 	  Language.create(:name => "Norwegian")
 	  Language.create(:name => "Persian")
 	  Language.create(:name => "Polish")
 	  Language.create(:name => "Portuguese")
 	  Language.create(:name => "Punjabi")
 	  Language.create(:name => "Romanian")
 	  Language.create(:name => "Russian")
 	  Language.create(:name => "Serbo-Croatian")
 	  Language.create(:name => "Slovak")
 	  Language.create(:name => "Slovenian")
 	  Language.create(:name => "Spanish")
 	  Language.create(:name => "Swedish")
 	  Language.create(:name => "Thai")
 	  Language.create(:name => "Turkish")
 	  Language.create(:name => "Ukrainian")
 	  Language.create(:name => "Vietnamesec")
  end

  def self.down
    Language.delete_all
  end
end
