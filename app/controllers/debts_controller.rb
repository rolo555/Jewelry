class DebtsController < ApplicationController
  active_scaffold :debt do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :payment_date, :debtor, :addresses, :phone_numbers, :total_amount, :currency, :total_amount_with_currency, :payments, :balance, :status

    #Configurar las columnas que se mostrarán al editar
    conf.columns = :payment_date, :debtor, :addresses, :phone_numbers, :price, :payments, :balance

    conf.create.columns.exclude :status, :balance
    conf.update.columns.exclude :status

    #Configurar las columnas que se mostrarán al listar
    conf.list.columns = :payment_date, :debtor, :price, :balance, :jewelry

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :debtor, :addresses, :price, :payments, :balance

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns = :debtor, :payment_date, :jewelry, :status
    conf.columns[:jewelry].search_ui = :text
    conf.columns[:jewelry].search_sql = "jewelries.jewelry_code"
    conf.columns[:status].search_ui = :text
    conf.columns[:status].search_sql = "jewelries.status"

    #Desactivar enlace que abre la joya
    conf.columns[:jewelry].clear_link

    #Configurar de la fecha de pago
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => true }

    #Mostrar currency con un radio button
    conf.columns[:currency].form_ui = :radio
    conf.columns[:currency].options = {:options => [:usd, :bob]}

    #Agregar estilo disabled a balance
    conf.columns[:balance].options[:disabled] = "disabled"

    #Eliminar link para crear y eliminar
    conf.create.link = false
    conf.delete.link = false
  end

end
