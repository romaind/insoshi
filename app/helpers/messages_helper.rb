module MessagesHelper
  
  def list_link_with_active(name, options = {}, html_options = {}, &block)
    if current_page?(options)
      name += "on.gif"
    else
     name += "off.gif"
    end
    content_tag(:li, link_to(image_tag(name), options, html_options, &block))
  end
end