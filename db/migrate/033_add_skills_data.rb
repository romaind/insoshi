class AddSkillsData < ActiveRecord::Migration
  def self.up
    Skill.delete_all
    Skill.create(:title => "3D animation")
 	  Skill.create(:title => "Advertising")
 	  Skill.create(:title => "Animation")
 	  Skill.create(:title => "Architecture")
 	  Skill.create(:title => "Art direction")
 	  Skill.create(:title => "Branding")
 	  Skill.create(:title => "Caricature")
 	  Skill.create(:title => "Carpentry")
 	  Skill.create(:title => "Cartooning")
 	  Skill.create(:title => "Ceramics")
 	  Skill.create(:title => "Character design")
 	  Skill.create(:title => "Choregraphy")
 	  Skill.create(:title => "Cinematography")
 	  Skill.create(:title => "Comedy")
 	  Skill.create(:title => "Comic strip")
 	  Skill.create(:title => "Computer animation")
 	  Skill.create(:title => "Consulting")
 	  Skill.create(:title => "Costume design")
 	  Skill.create(:title => "Crafts")
 	  Skill.create(:title => "Culinary arts")
 	  Skill.create(:title => "Dance")
 	  Skill.create(:title => "Design")
 	  Skill.create(:title => "Digital art")
 	  Skill.create(:title => "Digital imaging")
 	  Skill.create(:title => "Digital photography")
 	  Skill.create(:title => "Documentary")
 	  Skill.create(:title => "Drawing")
 	  Skill.create(:title => "Editing")
 	  Skill.create(:title => "Editorial design")
 	  Skill.create(:title => "Education")
 	  Skill.create(:title => "Engineering")
 	  Skill.create(:title => "Enology")
 	  Skill.create(:title => "Entrepreneurship")
 	  Skill.create(:title => "Exhibition design")
 	  Skill.create(:title => "Fashion")
 	  Skill.create(:title => "Film")
 	  Skill.create(:title => "Flash animation")
 	  Skill.create(:title => "Floral design")
 	  Skill.create(:title => "Furniture design")
 	  Skill.create(:title => "Game design")
 	  Skill.create(:title => "Glass working")
 	  Skill.create(:title => "Graffiti arts")
 	  Skill.create(:title => "Graphic design")
 	  Skill.create(:title => "Hair styling")
 	  Skill.create(:title => "Hardware architecture")
 	  Skill.create(:title => "Illustration")
 	  Skill.create(:title => "Industrial design")
 	  Skill.create(:title => "Infographism")
 	  Skill.create(:title => "Interaction design")
 	  Skill.create(:title => "Interior design")
 	  Skill.create(:title => "Jewelry design")
 	  Skill.create(:title => "Journalism")
 	  Skill.create(:title => "Landscape architecture")
 	  Skill.create(:title => "Leather working")
 	  Skill.create(:title => "Lighting design")
 	  Skill.create(:title => "Machinima")
 	  Skill.create(:title => "Makeup arts")
 	  Skill.create(:title => "Marketing")
 	  Skill.create(:title => "Masonry")
 	  Skill.create(:title => "Metal working")
 	  Skill.create(:title => "Multimedia")
 	  Skill.create(:title => "Music")
 	  Skill.create(:title => "Music composition")
 	  Skill.create(:title => "Music production")
 	  Skill.create(:title => "Package design")
 	  Skill.create(:title => "Painting")
 	  Skill.create(:title => "Pastry arts")
 	  Skill.create(:title => "Perfumery")
 	  Skill.create(:title => "Photo illustration")
 	  Skill.create(:title => "Photography")
 	  Skill.create(:title => "Photojournalism")
 	  Skill.create(:title => "Podcasting")
 	  Skill.create(:title => "Poetry")
 	  Skill.create(:title => "Print design")
 	  Skill.create(:title => "Product design")
 	  Skill.create(:title => "Production")
 	  Skill.create(:title => "Programming")
 	  Skill.create(:title => "Publishing")
 	  Skill.create(:title => "Radio")
 	  Skill.create(:title => "Sculpting")
 	  Skill.create(:title => "Short film")
 	  Skill.create(:title => "Stop motion animation")
 	  Skill.create(:title => "Storyboarding")
 	  Skill.create(:title => "Technical drawing")
 	  Skill.create(:title => "Television")
 	  Skill.create(:title => "Textile design")
 	  Skill.create(:title => "Theater")
 	  Skill.create(:title => "Toy design")
 	  Skill.create(:title => "Typography")
 	  Skill.create(:title => "Urbanism")
 	  Skill.create(:title => "Video")
 	  Skill.create(:title => "Video blogging")
 	  Skill.create(:title => "Video game design")
 	  Skill.create(:title => "Visual arts")
 	  Skill.create(:title => "Visual effects")
 	  Skill.create(:title => "Web design")
 	  Skill.create(:title => "Web development")
 	  Skill.create(:title => "Wood working")
 	  Skill.create(:title => "Writing")
  end

  def self.down
    Skill.delete_all
  end
end
