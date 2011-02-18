class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    conf.list.columns = :payment_date, :concept, :jewelry, :bs, :usd
    #Sumatoria de bs y usd
    conf.columns[:bs].calculate = :sum
    conf.columns[:usd].calculate = :sum
  end
end
