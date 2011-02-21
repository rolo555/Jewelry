class SalesController < ApplicationController
  active_scaffold :sale do |conf|
    conf.columns = :date_of_sale, :bs, :usd
    conf.show.columns = :date_of_sale, :price
    #configuracion de la fecha de venta
    conf.columns[:date_of_sale].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }
  end

end
