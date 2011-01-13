class BoxesController < ApplicationController
  active_scaffold :boxe do |conf|
    conf.columns = [:code, :description]
  end
end
