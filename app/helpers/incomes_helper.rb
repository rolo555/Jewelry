module IncomesHelper

  def income_payment_type_search_column(record, options)
    select :record, 
      :payment_type,
      Income.payment_types.map {|t| [I18n.t!(t.downcase, :scope => "activerecord.attributes.income"), t]},
      { :include_blank => true },
      options
  end
  
end
