class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    conf.list.columns = :payment_date, :concept, :jewelry, :amount
    conf.columns.exclude :jewelry
    #sumatoria de amount
    conf.columns[:amount].calculate = :sum
    
    #modificar el link a ver
    conf.columns[:jewelry].actions_for_association_links = [:show]

  end
end
