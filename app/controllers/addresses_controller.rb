class AddressesController < ApplicationController
  active_scaffold :address do |conf|
    #Configuración de las columnas que se mostrarán en general
    conf.columns = [:address]
  end
end
