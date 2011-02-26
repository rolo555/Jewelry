class IncomesController < ApplicationController
  active_scaffold :income do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :concept, :bs, :usd

    #Configurar las columnas que se mostrarán al listar
    conf.list.columns = :payment_date, :concept, :bs, :usd

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :payment_date, :concept, :price

    #Mostrar la sumatoria de bs y usd
    conf.columns[:bs].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Activar búsqueda avanzada
    conf.actions << :field_search

    #Agregar payment_date y payment_type a la búsqueda
    conf.field_search.columns << :payment_date
    conf.field_search.columns << :payment_type

    #Mostrar payment_type con un select
    conf.columns[:payment_type].search_ui = :select

    #Eliminar link para eliminar, actualizar y crear
    conf.delete.link = false
    conf.update.link = false
    conf.create.link = false
  end
  
end
