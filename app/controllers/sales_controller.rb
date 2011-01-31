class SalesController < ApplicationController
  active_scaffold :sale do |conf|
    conf.columns = :date_of_sale, :amount
  end

end
