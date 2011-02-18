include ModelHelper

class Jewelry < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  belongs_to :box
  has_one :expense, :dependent => :destroy
  has_one :sale, :dependent => :destroy
  has_one :debt, :dependent => :destroy

  #Fotografia
  has_attached_file :photo,
    :styles => { :thumbnail => "40x40" },
    :default_url => "missing.png"

  def before_validation
    sanitizate_strings :jewelry_code
  end

  #Validaciones
  validates_presence_of :box
  validate :purchase_date_cant_be_greater_than_today

  def to_label
    "#{description}"
  end

  def after_create
    self.expense = Expense.new :created_at => self.created_at, :updated_at => self.updated_at
    self.expense.save
    nil
  end

  def before_create
    copy_product_auto_code
    box.product.increase_product_auto_code
    self.status = I18n.t! :on_sale
    nil
  end

  def before_save
    self.jewelry_code = "#{self.box.box_code}-#{self.product_auto_code}"
    nil
  end

  def after_save
    self.expense.concept = "Compra de joya."
    self.expense.amount = self.purchase_price
    self.expense.payment_date = self.purchase_date
    self.expense.save
    nil
  end

  def cash_sale_date_message
    sale.date_message if sale.present?
  end

  def sale_on_account_date_message
    debt.date_message if debt.present?
  end

  def purchase_date_cant_be_greater_than_today
    unless self.purchase_date.nil?
      if (self.purchase_date <=> Date.today) > 0
        errors.add :purchase_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!(:today)}"
      end
    end
  end

  #setter y getter de products, necesarios para realizar el update del campo
  #virtual products, al crear y al buscar
  def products=(dummy)
  end

  def products
  end
  
  def copy_product_auto_code
    self.product_auto_code = box.product.product_auto_code 
  end

  private :copy_product_auto_code

  def sale_authorized_for_read?
    self.debt.blank?
  end

  def debt_authorized_for_read?
    self.sale.blank?
  end

  def self.status_types
    all.map {|j| j.status}.uniq
  end
end
