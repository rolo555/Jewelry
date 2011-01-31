class SalesController < ApplicationController
  active_scaffold :sale do |conf|
    conf.columns = :jewelry_name, :date_of_sale, :amount
  end

  def do_new
    super
    @record.jewelry = Jewelry.find(params[:id]) if params[:id].present?
    @record
  end

end
