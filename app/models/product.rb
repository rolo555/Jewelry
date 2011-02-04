include ModelHelper

class Product < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  has_many :boxes, :dependent => :destroy

  #Validaciones
  validates_presence_of :name, :boxes
  validates_length_of :name, :maximum => 50, :if => "self.name.presence"
  validates_uniqueness_of :name, :case_sensitive => false

  def before_validation
    sanitizate_strings :name
  end

  def to_label
    "#{name}"
  end

  def to_s
    name
  end

  def increase_product_auto_code
    self.product_auto_code = self.product_auto_code + 1
    self.save
    nil
  end

  def before_create
    self.product_auto_code = 0
    nil
  end
end
