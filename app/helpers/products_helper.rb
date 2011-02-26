module ProductsHelper

  def product_boxes_show_column(record)
    list(record.boxes) { |box| box.to_label }
  end

end
