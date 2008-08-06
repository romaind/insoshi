class AddSkillsData < ActiveRecord::Migration
  def self.up
    Skill.delete_all
    Skill.create(:name=>'3Danimation')
    Skill.create(:name=>'Advertising')
    Skill.create(:name=>'Animation')
    Skill.create(:name=>'Architecture')
    Skill.create(:name=>'Artdirection')
    Skill.create(:name=>'Branding')
    Skill.create(:name=>'Caricature')
    Skill.create(:name=>'Carpentry')
    Skill.create(:name=>'Cartooning')
    Skill.create(:name=>'Ceramics')
    Skill.create(:name=>'Characterdesign')
    Skill.create(:name=>'Choregraphy')
    Skill.create(:name=>'Cinematography')
    Skill.create(:name=>'Comedy')
    Skill.create(:name=>'Comicstrip')
    Skill.create(:name=>'Computeranimation')
    Skill.create(:name=>'Consulting')
    Skill.create(:name=>'Costumedesign')
    Skill.create(:name=>'Crafts')
    Skill.create(:name=>'Culinaryarts')
    Skill.create(:name=>'Dance')
    Skill.create(:name=>'Design')
    Skill.create(:name=>'Digitalart')
    Skill.create(:name=>'Digitalimaging')
    Skill.create(:name=>'Digitalphotography')
    Skill.create(:name=>'Documentary')
    Skill.create(:name=>'Drawing')
    Skill.create(:name=>'Editing')
    Skill.create(:name=>'Editorialdesign')
    Skill.create(:name=>'Education')
    Skill.create(:name=>'Engineering')
    Skill.create(:name=>'Enology')
    Skill.create(:name=>'Entrepreneurship')
    Skill.create(:name=>'Exhibitiondesign')
    Skill.create(:name=>'Fashion')
    Skill.create(:name=>'Film')
    Skill.create(:name=>'Flashanimation')
    Skill.create(:name=>'Floraldesign')
    Skill.create(:name=>'Furnituredesign')
    Skill.create(:name=>'Gamedesign')
    Skill.create(:name=>'Glassworking')
    Skill.create(:name=>'Graffitiarts')
    Skill.create(:name=>'Graphicdesign')
    Skill.create(:name=>'Hairstyling')
    Skill.create(:name=>'Hardwarearchitecture')
    Skill.create(:name=>'Illustration')
    Skill.create(:name=>'Industrialdesign')
    Skill.create(:name=>'Infographism')
    Skill.create(:name=>'Interactiondesign')
    Skill.create(:name=>'Interiordesign')
    Skill.create(:name=>'Jewelrydesign')
    Skill.create(:name=>'Journalism')
    Skill.create(:name=>'Landscapearchitecture')
    Skill.create(:name=>'Leatherworking')
    Skill.create(:name=>'Lightingdesign')
    Skill.create(:name=>'Machinima')
    Skill.create(:name=>'Makeuparts')
    Skill.create(:name=>'Marketing')
    Skill.create(:name=>'Masonry')
    Skill.create(:name=>'Metalworking')
    Skill.create(:name=>'Multimedia')
    Skill.create(:name=>'Music')
    Skill.create(:name=>'Musiccomposition')
    Skill.create(:name=>'Musicproduction')
    Skill.create(:name=>'Packagedesign')
    Skill.create(:name=>'Painting')
    Skill.create(:name=>'Pastryarts')
    Skill.create(:name=>'Perfumery')
    Skill.create(:name=>'Photoillustration')
    Skill.create(:name=>'Photography')
    Skill.create(:name=>'Photojournalism')
    Skill.create(:name=>'Podcasting')
    Skill.create(:name=>'Poetry')
    Skill.create(:name=>'Printdesign')
    Skill.create(:name=>'Productdesign')
    Skill.create(:name=>'Production')
    Skill.create(:name=>'Programming')
    Skill.create(:name=>'Publishing')
    Skill.create(:name=>'Radio')
    Skill.create(:name=>'Sculpting')
    Skill.create(:name=>'Shortfilm')
    Skill.create(:name=>'Stopmotionanimation')
    Skill.create(:name=>'Storyboarding')
    Skill.create(:name=>'Technicaldrawing')
    Skill.create(:name=>'Television')
    Skill.create(:name=>'Textiledesign')
    Skill.create(:name=>'Theater')
    Skill.create(:name=>'Toydesign')
    Skill.create(:name=>'Typography')
    Skill.create(:name=>'Urbanism')
    Skill.create(:name=>'Video')
    Skill.create(:name=>'Videoblogging')
    Skill.create(:name=>'Videogamedesign')
    Skill.create(:name=>'Visualarts')
    Skill.create(:name=>'Visualeffects')
    Skill.create(:name=>'Webdesign')
    Skill.create(:name=>'Webdevelopment')
    Skill.create(:name=>'Woodworking')
    Skill.create(:name=>'Writing')
  end

  def self.down
    Skill.delete_all
  end
end
