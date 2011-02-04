class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :box, :weight, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :product_auto_code, :box, :sale, :debt

    #Descativar enlace que abre el nested
    conf.columns[:box].clear_link

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :status
    conf.columns[:status].search_ui = :select

    conf.columns[:sale].actions_for_association_links = [:show, :new]
    conf.columns[:sale].link.label = :cash_sale

    conf.columns[:debt].actions_for_association_links = [:show, :new]
    conf.columns[:debt].link.label = :sale_on_account
  end
end