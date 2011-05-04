class PhoneNumber < ActiveRecord::Base

  #Relaciones
  belongs_to :debt

  #Validaciones
  validates_presence_of :number
  validates_length_of :number, :maximum => 50, :if => "number.present?"

  def before_update
    if self.number_changed?
      Record.create :table => "Deuda",
        :code => "Venta de la joya #{self.jewelry.jewelry_code}",
        :message => "Se modificó el número de telefono\nAntes era '#{self.number_was}' y ahora es '#{self.number}'"
    end
  end

  def jewelry
    debt.jewelry if debt.present?
  end

  def number=(value)
    value.strip!
    self.write_attribute(:number, value)
  end

  def to_label
    number.to_s
  end

end
