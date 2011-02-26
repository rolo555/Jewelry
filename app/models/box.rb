include ModelHelper

class Box < ActiveRecord::Base

  #Relaciones
  belongs_to :product
  has_many :jewelries, :dependent => :destroy

  #Validaciones
  validates_presence_of :box_code, :description
  validates_length_of :box_code, :maximum => 50, :if => "box_code.present?"
  validates_length_of :description, :maximum => 50, :if => "description.present?"
  validates_uniqueness_of :box_code, :case_sensitive => false

  #Fotografia
  has_attached_file :photo,
    :styles => { :thumbnail => "40x40" },
    :default_url => "missing.png"

  #Permisos
  def authorized_for_delete?
    false
  end

  def box_code=(value)
    value.strip! if value.present?
    self.write_attribute(:box_code, value)
  end

  def description=(value)
    value.strip! if value.present?
    self.write_attribute :description, value
  end

  def to_label
    "#{box_code} - #{description}"
  end

end
