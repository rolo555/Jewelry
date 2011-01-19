class BoxesController < ApplicationController
  active_scaffold :boxe do |conf|
    conf.columns = [:box_code, :description]
  end
end
