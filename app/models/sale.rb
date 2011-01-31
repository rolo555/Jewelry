class Sale < ActiveRecord::Base
  #Relaciones
  belongs_to :jewelry

  #Validaciones
  validates_presence_of :amount, :date_of_sale
  validates_uniqueness_of :jewelry

  def to_label
    "#{self.class.human_name} de #{self.jewelry}"
  end
end
