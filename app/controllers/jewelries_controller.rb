class JewelriesController < ApplicationController
  active_scaffold :jewelrie do |conf|
    conf.columns = :products, :box, :weight, :measurement_unit, :weight_and_measurement_unit, :description, :photo, :purchase_date, :purchase_price
    conf.list.columns = :photo, :jewelry_code, :box, :sale, :debt
    conf.show.columns = :box, :weight_and_measurement_unit, :description, :photo, :purchase_date, :purchase_price

    conf.columns[:box].form_ui = :select
    conf.columns[:products].update_column = :box

    #Descativar enlace que abre el nested
    conf.columns[:box].clear_link

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :product_auto_code
    conf.field_search.columns << :status
    conf.columns[:status].search_ui = :select

    conf.columns[:sale].actions_for_association_links = [:show, :new]
    conf.columns[:sale].link.label = I18n.t! :cash_sale

    conf.columns[:debt].actions_for_association_links = [:show, :new]
    conf.columns[:debt].link.label = I18n.t! :sale_on_account

    #configuracion de la fecha de compra
    conf.columns[:purchase_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => true }

    #No mostrar el link delete
    conf.delete.link = false

    conf.columns[:measurement_unit].form_ui = :radio
    conf.columns[:measurement_unit].options[:options] = Jewelry.measurement_units

    #test de mensaje
    conf.action_links.add :cancel,
      :type => :member,
      :page => true,
      :confirm => "#{I18n.t!('confirmation message')}"

  end

  def cancel
    jewelry = Jewelry.find params[:id]
    flash[:warning] = "#{I18n.t('refund message')} #{jewelry.calculate_refund}"
    jewelry.destroy_dependences
    redirect_to :action=>'index'
  end

end