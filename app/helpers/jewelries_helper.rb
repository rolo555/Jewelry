module JewelriesHelper
  def jewelry_sale_column(record)
    record.cash_sale_date_message
  end

  def jewelry_debt_column(record)
    record.sale_on_account_date_message
  end

  def jewelry_status_search_column(record, options)
    select nil, nil, Jewelry.status_types, {:include_blank => true}, options
  end

  def jewelry_products_form_column(record, options)
    select nil, nil, options_for_select(Product.all), {:include_blank => true}, options
  end

  def options_for_association_conditions(association)
    if association.name == :box and params[:value].present?
      id_product = Product.first(:conditions => {:name => params[:value]}).id
      {'boxes.product_id' => id_product }
    else
      super
    end
  end

  def jewelry_weight_and_measurement_unit_form_column(record, options)
    form_column(active_scaffold_config.columns[:weight], nil) + " " +
      form_column(active_scaffold_config.columns[:measurement_unit], nil)
  end

  def jewelry_amount_with_currency_form_column(record, options)
    form_column(active_scaffold_config.columns[:amount], nil) +
      form_column(active_scaffold_config.columns[:currency], nil)
  end
end
