class DebtsController < ApplicationController
  active_scaffold :debt do |conf|
    conf.columns = :payment_date, :debtor, :addresses, :phone_numbers, :total_amount, :payments, :balance
    conf.columns.exclude :jewelry
    conf.list.columns = :debtor, :total_amount, :balance, :jewelry
    conf.show.columns = :debtor, :addresses, :total_amount, :payments, :balance

    #configuracion de la fecha de compra
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => true }
  end
end
