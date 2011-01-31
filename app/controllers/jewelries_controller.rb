class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :box, :weight, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :product_auto_code, :box

    #Descativar enlace que abre el nested
    conf.columns[:box].clear_link

    #boton de venta
    conf.action_links.add :sale,
      :type => :member,
      :page => true,
      :parameters => { :controller => 'sales', :action => 'new' }

    #Activar busqueda avanzada
    conf.actions << :field_search
  end
end
