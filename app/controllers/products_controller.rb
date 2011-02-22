class ProductsController < ApplicationController
  active_scaffold :product do |conf|
    conf.columns = :name, :boxes
    conf.list.columns << :list_of_boxes
    conf.list.columns.exclude :boxes
    #Agregacion de multipart para que agrege los archivos adjuntos de las fotos
    #de boxes
    conf.create.multipart = true
    conf.update.multipart = true

    #No mostrar el link delete
    conf.delete.link = false
  end
end
