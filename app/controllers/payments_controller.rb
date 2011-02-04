class PaymentsController < ApplicationController
  active_scaffold :payment do |conf|
    conf.columns = :amount, :payment_date
    #configuracion de la fecha
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }
  end
end
