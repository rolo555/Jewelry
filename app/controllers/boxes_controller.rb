class BoxesController < ApplicationController
  active_scaffold :boxe do |conf|
    #Configuración de las columnas que se mostrarán en general
    conf.columns = [:photo, :box_code, :description]

    #Quitar el link en la acción delete
    conf.delete.link = false
  end
end
