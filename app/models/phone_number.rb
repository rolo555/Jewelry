class PhoneNumber < ActiveRecord::Base

  #Relaciones
  belongs_to :debt

  #Validaciones
  validates_presence_of :number
  validates_length_of :number, :maximum => 50, :if => "number.present?"

  def number=(value)
    value.strip!
    self.write_attribute(:number, value)
  end

  def to_label
    number.to_s
  end

end
