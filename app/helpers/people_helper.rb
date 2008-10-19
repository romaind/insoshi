module PeopleHelper

  def message_links(people)
    people.map { |p| email_link(p)}
  end

  # Return a person's image link.
  # The default is to display the person's icon linked to the profile.
  def image_link(person, options = {})
    link = options[:link] || person
    image = options[:image] || :icon
    image_options = { :title => h(person.name), :alt => h(person.name) }
    unless options[:image_options].nil?
      image_options.merge!(options[:image_options]) 
    end
    link_options =  { :title => h(person.name) }
    unless options[:link_options].nil?                    
      link_options.merge!(options[:link_options])
    end
    content = image_tag(person.send(image), image_options)
    # This is a hack needed for the way the designer handled rastered images
    # (with a 'vcard' class).
    if options[:vcard]
      content = %(#{content}#{content_tag(:span, h(person.name), 
                                                 :class => "fn" )})
    end
    link_to(content, link, link_options)
  end

  # Link to a person (default is by name).
  # TODO: refactor this thing.
  def person_link(text, person = nil, html_options = nil)
    if person.nil?
      person = text
      text = person.first_name + " " + person.name
    elsif person.is_a?(Hash)
      html_options = person
      person = text
      text = person.first_name + " " + person.name
    end
    # We normally write link_to(..., person) for brevity, but that breaks
    # activities_helper_spec due to an RSpec bug.
    link_to(h(text), profile_path(person, "profile"), html_options)
  end
  
  #If the field is empty, display depending current person
  def display_empty_field(field, tab)
    if current_person?(@person)
        link = case field
          when "languages": "#person[language_ids][]"
          when "software": "#person[language_ids][]"
          when "tags": "#person_tag_list"
         # when "tags": "#person[language_ids][]"
          else "#person_" + field
          end
          
      haml_tag :div, { :class => "add"} do
        haml_tag :a, {:href => editprofile_path(@person, tab) + link} do
          haml_tag :img,{ :src => "../images/portfolio/add.gif"}
        end
        haml_tag :br
        haml_tag :a , "Add a " + field.singularize, {:href => editprofile_path(@person, tab) + link}
      end
    else
        "No " + field + "."
    end
  end
  
  private
    
    # Make captioned images.
    def captioned(images, captions)
      images.zip(captions).map do |image, caption|
        markaby do
          image << div { caption }
        end
      end
    end
end
