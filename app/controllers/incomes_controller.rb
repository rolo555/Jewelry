class IncomesController < ApplicationController
  before_filter :update_config
  
  active_scaffold :income do |conf|
    conf.columns = :concept, :amount
    conf.list.columns = :payment_date, :concept, :amount, :payment
    conf.show.columns = :payment_date, :concept, :amount

    conf.columns[:payment].actions_for_association_links = [:show]


    #sumatoria de amount
    conf.columns[:amount].calculate = :sum

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.field_search.columns << :payment_date
    conf.field_search.columns << :payment_type
    conf.columns[:payment_type].search_ui = :select

    #no mostrar link delete, edit y create
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
