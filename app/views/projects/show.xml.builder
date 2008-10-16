xml.instruct! :xml, :version => "1.0"
xml.playlist :version => "1", :xmlns => "http://xspf.org/ns/0/" do
  xml.title @project.title 
  xml.info person_project_url(@author, @project)
  xml.tracklist do
    @project.creations.each do |creation|
      xml.track do
        xml.title creation.id
        xml.creator @author.display_name
        xml.info person_project_creation_url(@author, @project, creation)
        xml.annotation @project.description
        xml.location "http://#{PersonMailer.global_prefs.server_name}#{creation.asset.item.url}"
        xml.image "http://#{PersonMailer.global_prefs.server_name}#{creation.asset.item.url(:preview)}"
      end
    end
  end
end