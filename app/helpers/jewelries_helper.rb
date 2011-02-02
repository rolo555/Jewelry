module JewelriesHelper
  def jewelry_sale_column(record)
    record.cash_sale_date_message
  end

  def jewelry_debt_column(record)
    record.sale_on_account_date_message
  end
end
