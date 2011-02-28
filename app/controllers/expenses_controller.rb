class ExpensesController < ApplicationController
  active_scaffold :expense do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :payment_date, :concept, :bob, :usd

    #Configurar las columnas que se mostrarán al listar
    conf.list.columns = :payment_date, :concept, :jewelry, :bob, :usd

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :payment_date, :concept, :jewelry, :price
    
    #Mostrar la sumatoria de bs y usd
    conf.columns[:bob].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Cambiar el link de jewelry
    conf.columns[:jewelry].actions_for_association_links = [:show]

    #Eliminar link para eliminar
    conf.delete.link = false

    #configuracion de la fecha de pago
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => true }

    #Activar búsqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns = :payment_date, :concept, :jewelry
    conf.columns[:concept].search_ui = :text
    conf.columns[:jewelry].search_ui = :text
    conf.columns[:jewelry].search_sql = "jewelries.jewelry_code"

  end
end
