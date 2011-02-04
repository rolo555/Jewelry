module JewelriesHelper
  def jewelry_sale_column(record)
    record.cash_sale_date_message
  end

  def jewelry_debt_column(record)
    record.sale_on_account_date_message
  end

  def jewelry_products_form_column(record, options)
    select nil, nil, options_for_select(Product.all), {:include_blank => as_('- select -')}, options
  end

  def options_for_association_conditions(association)
    if association.name == :box and params[:value].present?
      id_product = Product.first(:conditions => {:name => params[:value]}).id
      {'boxes.product_id' => id_product }
    else
      super
    end
  end
end
