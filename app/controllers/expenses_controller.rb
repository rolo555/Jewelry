class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    conf.list.columns = :payment_date, :concept, :jewelry, :amount
    #sumatoria de amount
    conf.columns[:amount].calculate = :sum
    
    #modificar el link a ver
    conf.columns[:jewelry].actions_for_association_links = [:show]

    #No mostrar el link delete
    conf.delete.link = false
  end
end
