class ExpensesController < ApplicationController
  before_filter :update_config
  
  active_scaffold :expense do |conf|
    conf.list.columns = :payment_date, :concept, :jewelry, :amount
    conf.columns.exclude :jewelry
    #sumatoria de amount
    conf.columns[:amount].calculate = :sum
    
    #modificar el link a ver
    conf.columns[:jewelry].actions_for_association_links = [:show]

    #no mostrar el link delete
    conf.delete.link = false

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
