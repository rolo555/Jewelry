class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :products, :box, :weight, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :product_auto_code, :box, :sale, :debt

    conf.columns[:box].form_ui = :select
    conf.columns[:products].update_column = :box

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

    #configuracion de la fecha de compra
    conf.columns[:purchase_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => false }
  end
end