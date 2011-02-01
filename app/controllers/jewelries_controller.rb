class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :box, :weight, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :product_auto_code, :box, :sale, :debt

    #Descativar enlace que abre el nested
    conf.columns[:box].clear_link

    #Activar busqueda avanzada
    conf.actions << :field_search

    conf.columns[:sale].actions_for_association_links = [:show, :new]
    conf.columns[:sale].link.label = :cash_sale
  end
end