class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    conf.list.columns = :payment_date, :concept, :jewelry, :bs, :usd

    #Sumatoria de bs y usd
    conf.columns[:bs].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Modificar el link a ver
    conf.columns[:jewelry].actions_for_association_links = [:show]

    #No mostrar el link delete
    conf.delete.link = false
  end
end
