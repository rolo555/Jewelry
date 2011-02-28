class PaymentsController < ApplicationController
  active_scaffold :payment do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :amount, :payment_date

    #Configurar de la fecha de pago
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }
  end
  
end
