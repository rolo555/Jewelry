class ProductsController < ApplicationController
  
  active_scaffold :product do |conf|
    #Configuración de las columnas que se mostrarán en general
    conf.columns = :name, :boxes

    #Desactivar enlace que abre las cajas
    conf.columns[:boxes].clear_link

    #Permitir subir adjuntos
    conf.create.multipart = true
    conf.update.multipart = true

    #Eliminar el link delete
    conf.delete.link = false
  end

end
