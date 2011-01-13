class ProductsController < ApplicationController
  active_scaffold :product do |conf|
    conf.columns = [:name, :boxes]
    conf.list.columns << :list_of_boxes
    conf.list.columns.exclude :boxes
  end
end
