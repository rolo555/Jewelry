class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    conf.list.columns = :payment_date, :concept, :jewelry, :amount
    #sumatoria de amount
    conf.columns[:amount].calculate = :sum
  end
end
