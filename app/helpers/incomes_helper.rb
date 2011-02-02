module IncomesHelper
  def income_payment_type_search_column(record, input_name)
    select :record, :payment_type, options_for_select({ as_(:payment) => "Payment", as_(:sale) => "Sale"  }), {:include_blank => as_('- select -')}, input_name
  end
end
