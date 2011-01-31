class IncomesController < ApplicationController
  active_scaffold :income do |conf|
    conf.columns = :concept, :amount
    conf.list.columns = :created_at, :concept, :amount
    conf.show.columns = :created_at, :concept, :amount
  end
end
