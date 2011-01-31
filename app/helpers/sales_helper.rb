module SalesHelper
  def sale_jewelry_name_form_column(record, options)
    content_tag "span", record.jewelry.to_label, options
  end
end
