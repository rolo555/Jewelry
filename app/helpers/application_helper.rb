# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def list(stuff, &block)
    content_tag(:ul, stuff.map { |thingie| content_tag(:li, yield(thingie)) })
  end

end
