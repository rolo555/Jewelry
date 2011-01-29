class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :box, :weight, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :weight
  end
end
