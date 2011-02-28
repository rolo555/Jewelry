class ProductsController < ApplicationController
  
  active_scaffold :product do |conf|
    #Configuración de las columnas que se mostrarán en general
    conf.columns = :name, :boxes

    #Activar busqueda avanzada
    conf.actions << :field_search
    conf.columns[:boxes].search_ui = :text
    conf.columns[:boxes].search_sql = "boxes.description||boxes.box_code"
    conf.columns[:name].search_ui = :text
    
    #Desactivar enlace que abre las cajas
    conf.columns[:boxes].clear_link

    #Permitir subir adjuntos
    conf.create.multipart = true
    conf.update.multipart = true

    #Eliminar el link delete
    conf.delete.link = false
  end

end
