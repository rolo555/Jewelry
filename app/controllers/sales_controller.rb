class SalesController < ApplicationController
  active_scaffold :sale do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :date_of_sale, :amount, :currency, :amount_with_currency

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :date_of_sale, :price

    #Configurar de la fecha de venta
    conf.columns[:date_of_sale].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }

    #Mostrar currency con un radio button
    conf.columns[:currency].form_ui = :radio
    conf.columns[:currency].options = { :options => [:usd, :bob] }
  end

end
