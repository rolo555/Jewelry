class BoxesController < ApplicationController
  active_scaffold :boxe do |conf|
    conf.columns = [:photo, :box_code, :description]

    #No mostrar el link delete
    conf.delete.link = false
  end
end
