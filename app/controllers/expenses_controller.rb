class ExpensesController < ApplicationController
  before_filter :update_config
  
  active_scaffold :expense do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :payment_date, :concept, :bob, :usd

    #Configurar las columnas que se mostrarán al listar
    conf.list.columns = :payment_date, :concept, :jewelry, :bob, :usd

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :payment_date, :concept, :jewelry, :price
    
    #Mostrar la sumatoria de bs y usd
    conf.columns[:bob].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Cambiar el link de jewelry
    conf.columns[:jewelry].actions_for_association_links = [:show]

    #Eliminar link para eliminar
    conf.delete.link = false

    #Configuracion de la fecha de pago
    conf.columns[:payment_date].options = {:end_year => Date.today.year-5, :start_year => Date.today.year, :include_blank => true }

    #Activar búsqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns = :payment_date, :concept, :jewelry
    conf.columns[:concept].search_ui = :text
    conf.columns[:jewelry].search_ui = :text
    conf.columns[:jewelry].search_sql = "jewelries.jewelry_code"

    #Agregar boton para descativar la paginación
    conf.action_links.add :show_all,
      :type => :collection,
      :parameters => { :id => " " },
      :page => true,
      :label => I18n.t!(:show_all)

  end

  def conditions_for_collection
    ["(bob > ?) OR (usd > ?)", 0, 0]
  end



  def update_config
    if params["pag"] == "true"
      active_scaffold_config.list.per_page = 9999999
    else
      active_scaffold_config.list.per_page = 15
    end
  end

  def show_all
    if params["pag"] == "true"
      redirect_to :action => :index
    else
      redirect_to :action => :index, :pag => true
    end
  end

end
