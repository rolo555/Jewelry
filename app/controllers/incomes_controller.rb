class IncomesController < ApplicationController
  before_filter :update_config
  
  active_scaffold :income do |conf|
    #Configurar las columnas que se mostrarán en general
    conf.columns = :concept, :bs, :usd

    #Configurar las columnas que se mostrarán al listar
    conf.list.columns = :payment_date, :concept, :bs, :usd

    #Configurar las columnas que se mostrarán al ver
    conf.show.columns = :payment_date, :concept, :price

    #Mostrar la sumatoria de bs y usd
    conf.columns[:bs].calculate = :sum
    conf.columns[:usd].calculate = :sum

    #Activar búsqueda avanzada
    conf.actions << :field_search

    #Agregar payment_date y payment_type a la búsqueda
    conf.field_search.columns << :payment_date
    conf.field_search.columns << :payment_type

    #Mostrar payment_type con un select
    conf.columns[:payment_type].search_ui = :select

    #Eliminar link para eliminar, actualizar y crear
    conf.delete.link = false
    conf.update.link = false
    conf.create.link = false

    #boton para mostrar todos
    conf.action_links.add :show_all,
      :type => :collection,
      :parameters => { :id => " " },
      :page => true,
      :label => I18n.t!(:show_all)

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
