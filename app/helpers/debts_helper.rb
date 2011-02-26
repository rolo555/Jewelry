module DebtsHelper

  def debt_total_amount_with_currency_form_column(record, options)
    options = {}
    options[:disabled] = "disabled" if ["edit", "update"].include? params[:action]
    form_column(active_scaffold_config.columns[:total_amount], nil, options) +
      form_column(active_scaffold_config.columns[:currency], nil, options)
  end

  def debt_debtor_form_column(record, options)
    options[:disabled] = "disabled" if ["edit", "update"].include? params[:action]
    active_scaffold_input_virtual(active_scaffold_config.columns[:debtor], options)
  end

  def debt_payments_show_column(record)
    list(record.payments) { |payment| payment.to_label }
  end

end
