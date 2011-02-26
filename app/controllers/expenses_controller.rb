class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :payment_date, :concept, :bs, :usd

    #Configurar las columnas que se mostrarán al listar
    conf.list.columns = :payment_date, :concept, :jewelry, :bs, :usd

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :payment_date, :concept, :jewelry, :price
    
    #Mostrar la sumatoria de bs y usd
    conf.columns[:bs].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Cambiar el link de jewelry
    conf.columns[:jewelry].actions_for_association_links = [:show]

    #Eliminar link para eliminar
    conf.delete.link = false
  end
end
