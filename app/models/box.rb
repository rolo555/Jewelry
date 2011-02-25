include ModelHelper

class Box < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :product
  has_many :jewelries

  #Validaciones
  validates_presence_of :box_code, :description
  validates_length_of :box_code, :maximum => 50, :if => "self.box_code.presence"
  validates_length_of :description, :maximum => 50, :if => "self.description.presence"
  validates_uniqueness_of :box_code, :case_sensitive => false

  #Fotografia
  has_attached_file :photo,
    :styles => { :thumbnail => "40x40" },
    :default_url => "missing.png"

  def before_validation
    sanitizate_strings :box_code, :description
  end

  def to_label
    "#{box_code} - #{description}"
  end

  #Desactivar delete
  def authorized_for_delete?
    false
  end
end
