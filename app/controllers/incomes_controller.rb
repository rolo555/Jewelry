class IncomesController < ApplicationController
  active_scaffold :income do |conf|
    conf.columns = :concept, :amount
    conf.list.columns = :created_at, :concept, :amount
    conf.show.columns = :created_at, :concept, :amount

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :created_at
    conf.field_search.columns << :payment_type
    conf.columns[:payment_type].search_ui = :select
  end
end
