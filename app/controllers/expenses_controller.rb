class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    conf.list.columns = :created_at, :concept, :jewelry, :amount
    #sumatoria de amount
    conf.columns[:amount].calculate = :sum
  end
end
