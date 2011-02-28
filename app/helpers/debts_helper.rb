module DebtsHelper

  def debt_total_amount_with_currency_form_column(record, options)
    form_column(active_scaffold_config.columns[:total_amount], nil) +
      form_column(active_scaffold_config.columns[:currency], nil)
  end

  def debt_debtor_form_column(record, options)
    if ["edit", "update"].include? params[:action]
      content_tag :span, record.debtor, options
    else
      active_scaffold_input_virtual(active_scaffold_config.columns[:debtor], options)
    end
  end

  def debt_price_form_column(record, options)
    content_tag :span, record.price, options
  end

  def debt_balance_with_currency_form_column(record, options)
    content_tag :span, record.balance_with_currency, options
  end

  def debt_payments_show_column(record)
    list(record.payments) { |payment| payment.to_label }
  end

  def debt_status_search_column(record, options)
    select nil, nil, Debt.status_types, {:include_blank => true}, options
  end

end
