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

  def after_save
    unless new_record?
      if self.jewelries.present?
        self.jewelries.each do |j|
          j.sale.update_income if j.sale.present?
          j.debt.update_incomes if j.debt.present?
        end
      end
    end
  end

  def before_update
    message = ""
    message << "Se modificó el código de la caja
    Antes era '#{box_code_was}' y ahora es '#{box_code}'
    " if box_code_changed?
    message << "Se modificó la descripción
    Antes era '#{description_was}' y ahora es '#{description}'
    " if description_changed?
    message << "Se modificó la fotografía
    " if photo_file_name_changed?
    create_record message if message.present?
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

  def create_record(message)
    Record.create :table => "Caja",
      :code => to_label,
      :message => message
  end

end

