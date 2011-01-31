class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :box, :weight, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :weight

    #boton de venta
    conf.action_links.add :sale,
      :type => :member,
      :page => true,
      :parameters => { :controller => 'sales', :action => 'new' }
  end

  def sale

  end
end
