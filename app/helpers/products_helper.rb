module ProductsHelper

#  def product_list_of_boxes_show_column(record)
#    boxes = Box.all(:conditions => {:product_id => record.id})
#    list = []
#    boxes.each_index { |index| list << content_tag("li", "#{boxes[index].to_label}")}
#    content_tag "ul", list.join(" ")
#  end

  def product_list_of_boxes_column(record)
    boxes = Box.all(:conditions => {:product_id => record.id})
    list = []
    boxes.each_index { |index| list << "#{boxes[index].to_label}" }
    list.join(", ")
  end

end
