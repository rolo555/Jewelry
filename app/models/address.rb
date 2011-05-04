class Address < ActiveRecord::Base

  #Relaciones
  belongs_to :debt

  #Validaciones
  validates_presence_of :address
  validates_length_of :address, :maximum => 100, :if => "address.present?"

  def before_update
    if self.address_changed?
      Record.create :table => "Deuda",
        :code => "Venta de la joya #{self.jewelry.jewelry_code}",
        :message => "Se modificó la dirección\nAntes era '#{self.address_was}' y ahora es '#{self.address}'"
    end
  end

  def jewelry
    debt.jewelry if debt.present?
  end

  def address=(value)
    value.strip!
    self.write_attribute(:address, value)
  end

  def to_label
    address
  end
  
end