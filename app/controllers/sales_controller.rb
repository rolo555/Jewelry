class SalesController < ApplicationController
  active_scaffold :sale do |conf|
    conf.columns = :date_of_sale, :amount
    #configuracion de la fecha de venta
    conf.columns[:date_of_sale].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }
  end

end
