class Sale < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_presence_of :amount, :date_of_sale
  validates_uniqueness_of :jewelry_id

  def to_label
    "Vendido el #{created_at.strftime("%d %B %Y - %H:%M")}"
  end
end
