class PaymentsController < ApplicationController
  active_scaffold :payment do |conf|
    conf.columns = :amount, :payment_date
  end
end
