class Product < ActiveRecord::Base

  #Relaciones
  has_many :boxes, :dependent => :destroy

  #Validaciones
  validates_presence_of :name, :boxes
  validates_length_of :name, :maximum => 50, :if => "name.present?"
  validates_uniqueness_of :name, :case_sensitive => false

  #Permisos
  def authorized_for_delete?
    false
  end

  def before_create
    self.product_auto_code = 1
    nil
  end

  def before_update
    if self.name_changed?
      Record.create :table => "Producto",
        :code => self.name_was,
        :message => "Se modificó el nombre.
      Antes era '#{self.name_was}' y ahora es '#{self.name}'"
    end
  end

  def increase_product_auto_code
    self.product_auto_code = self.product_auto_code + 1
    self.save!
    nil
  end

  def name=(value)
    value.strip! if value.present?
    self.write_attribute(:name, value)
  end

  def to_label
    name
  end

  def to_s
    to_label
  end

end
