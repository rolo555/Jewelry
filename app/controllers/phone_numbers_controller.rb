class PhoneNumbersController < ApplicationController

  active_scaffold :phone_number do |conf|
    #Configuración de las columnas que se mostrarán en general
    conf.columns = [:number]

    #Agregar a las columnas de listar la relación deuda
    conf.list.columns.add :debt
  end

end
