class DebtsController < ApplicationController
  active_scaffold :debt do |conf|
    conf.columns = :debtor, :addresses, :phone_numbers, :total_amount, :currency, :total_amount_with_currency, :payments, :balance
    conf.columns.exclude :jewelry
    conf.list.columns = :debtor, :price, :balance, :jewelry
    conf.show.columns = :debtor, :addresses, :price, :payments, :balance

    conf.columns[:currency].form_ui = :radio
    conf.columns[:currency].options[:options] = Sale.currencies

    conf.columns[:balance].options[:disabled] = "disabled"
  end
end
