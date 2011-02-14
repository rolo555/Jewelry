class IncomesController < ApplicationController
  active_scaffold :income do |conf|
    conf.columns = :concept, :amount
    conf.list.columns = :payment_date, :concept, :amount
    conf.show.columns = :payment_date, :concept, :amount

    #sumatoria de amount
    conf.columns[:amount].calculate = :sum

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :created_at
    conf.field_search.columns << :payment_type
    conf.columns[:payment_type].search_ui = :select
  end
end
