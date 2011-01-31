class Sale < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry
  has_one :income, :as => :payment, :dependent => :destroy

  #Validaciones
  validates_presence_of :amount, :date_of_sale
  validates_uniqueness_of :jewelry_id

  def to_label
    "Vendido el #{created_at.strftime("%d %B %Y - %H:%M")}"
  end

  def after_create
    self.income = Income.new :created_at => self.created_at, :updated_at => self.updated_at
    self.income.save
  end
  
  def after_save
    self.income.concept = "Venta de joya"
    self.income.amount = amount
    self.income.save
  end

end
