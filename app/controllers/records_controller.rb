class RecordsController < ApplicationController
  active_scaffold :record do |conf|
    conf.columns = :created_at, :table, :code, :message

    conf.delete.link = false
    conf.update.link = false
    conf.create.link = false
  end
end
