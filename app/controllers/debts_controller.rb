class DebtsController < ApplicationController
  active_scaffold :debt do |conf|
    conf.columns = :debtor, :addresses, :phone_numbers, :total_amount, :payments, :balance
    conf.columns.exclude :jewelry
    conf.list.columns = :debtor, :total_amount, :balance, :jewelry
    conf.show.columns = :debtor, :addresses, :total_amount, :payments, :balance
  end
end
