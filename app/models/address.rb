class Address < ActiveRecord::Base

  #Relaciones
  belongs_to :debt

  #Validaciones
  validates_presence_of :address
  validates_length_of :address, :maximum => 100, :if => "address.present?"

  def address=(value)
    value.strip!
    self.write_attribute(:address, value)
  end

  def to_label
    address
  end
  
end