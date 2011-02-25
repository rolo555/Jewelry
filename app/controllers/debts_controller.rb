class DebtsController < ApplicationController
  active_scaffold :debt do |conf|
    conf.columns = :payment_date, :debtor, :addresses, :phone_numbers, :total_amount, :currency, :total_amount_with_currency, :payments, :balance
    conf.columns.exclude :jewelry
    conf.list.columns = :debtor, :price, :balance, :jewelry
    conf.show.columns = :debtor, :addresses, :price, :payments, :balance

    #Desactivar enlace que abre la joya
    conf.columns[:jewelry].clear_link

    #configuracion de la fecha de compra
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => true }

    conf.columns[:currency].form_ui = :radio
    conf.columns[:currency].options[:options] = Sale.currencies

    conf.columns[:balance].options[:disabled] = "disabled"
  end
end
