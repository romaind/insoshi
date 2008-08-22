module MessagesHelper
  
  def list_link_with_active(name, options = {}, html_options = {}, &block)
    name += "off.gif"
    name += "on.gif" if current_page?(options)
    content_tag(:li, link_to(image_tag(name), options, html_options, &block))
  end
end