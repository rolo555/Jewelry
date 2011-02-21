class IncomesController < ApplicationController
  active_scaffold :income do |conf|
    conf.columns = :concept, :bs, :usd
    conf.list.columns = :payment_date, :concept, :bs, :usd
    conf.show.columns = :payment_date, :concept, :price

    #Sumatoria de bs y usd
    conf.columns[:bs].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :payment_date
    conf.field_search.columns << :payment_type
    conf.columns[:payment_type].search_ui = :select
  end
end
