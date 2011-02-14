class BoxesController < ApplicationController
  active_scaffold :boxe do |conf|
    conf.columns = [:photo, :box_code, :description]
  end
end
