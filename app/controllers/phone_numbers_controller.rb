class PhoneNumbersController < ApplicationController

  active_scaffold :phone_number do |conf|
    #Configuración de las columnas que se mostrarán en general
    conf.columns = [:number]
  end

end
