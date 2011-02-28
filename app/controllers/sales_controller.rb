class SalesController < ApplicationController
  active_scaffold :sale do |conf|
    conf.columns = :date_of_sale, :amount, :currency, :amount_with_currency
    conf.show.columns = :date_of_sale, :price
    #configuracion de la fecha de venta
    conf.columns[:date_of_sale].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }

    conf.columns[:currency].form_ui = :radio
    conf.columns[:currency].options = { :options => [:usd, :bob] }
  end

end
