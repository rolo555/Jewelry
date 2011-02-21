class IncomesController < ApplicationController
  active_scaffold :income do |conf|
    conf.columns = :concept, :amount
    conf.list.columns = :payment_date, :concept, :amount, :payment
    conf.show.columns = :payment_date, :concept, :amount

    conf.columns[:payment].actions_for_association_links = [:show]


    #sumatoria de amount
    conf.columns[:amount].calculate = :sum

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :payment_date
    conf.field_search.columns << :payment_type
    conf.columns[:payment_type].search_ui = :select
  end
end
