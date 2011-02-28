module SalesHelper

  def sale_amount_with_currency_form_column(record, options)
    form_column(active_scaffold_config.columns[:amount], nil) +
      form_column(active_scaffold_config.columns[:currency], nil)
  end
  
end
