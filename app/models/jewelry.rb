include ModelHelper

class Jewelry < ActiveRecord::Base

  CURRENCIES = [:usd, :bob]

  #Relaciones
  belongs_to :box
  has_one :expense, :dependent => :destroy
  has_one :sale, :dependent => :destroy
  has_one :debt, :dependent => :destroy

  #Fotografia
  has_attached_file :photo,
    :styles => { :thumbnail => "40x40" },
    :default_url => "missing.png"

  #Validaciones
  validates_presence_of :box
  validate :purchase_date_cant_be_greater_than_today

  def purchase_date_cant_be_greater_than_today
    if self.purchase_date.present? and self.purchase_date > Date.today
      errors.add :purchase_date, "#{I18n.t!('can\'t be greater than')} #{I18n.t!(:today)}"
    end
  end

  #Permisos
  def sale_authorized_for_read?
    self.debt.blank?
  end

  def debt_authorized_for_read?
    self.sale.blank?
  end

  def authorized_for_delete?
    false
  end

  def authorized_for_cancel?
    self.status != I18n.t!(:on_sale)
  end

  def before_create
    copy_product_auto_code
    self.status = I18n.t! :on_sale
    generate_jewelry_code
    nil
  end

  def before_save
    unless new_record?
      if self.box_id_changed?
        copy_product_auto_code
        generate_jewelry_code
        box.product.increase_product_auto_code
      end
    end
  end

  def after_create
    box.product.increase_product_auto_code
    self.expense = Expense.new :concept => I18n.t!("jewelry purchase"), :usd => 0
    self.expense.save!
    nil
  end

  def after_save
    self.expense.concept = I18n.t! "jewelry purchase"
    self.expense.update_amount self.amount, self.currency
    self.expense.payment_date = self.purchase_date
    self.expense.save!
    nil
  end

  def generate_jewelry_code
    self.jewelry_code = "#{self.box.box_code}-#{self.product_auto_code}"
  end

  def copy_product_auto_code
    self.product_auto_code = box.product.product_auto_code
  end

  def product_auto_code
    self.box.product.product_auto_code
  end

  def cash_sale_date_message
    sale.date_message if sale.present?
  end

  def sale_on_account_date_message
    debt.date_message if debt.present?
  end

  #setter y getter de products, necesarios para realizar el update del campo
  #virtual products, al crear y al buscar
  def products=(dummy)
  end

  def products
  end
  
  def self.status_types
    all.map {|j| j.status}.uniq
  end

  def weight_and_measurement_unit
    "#{weight} #{I18n.t!(measurement_unit) if measurement_unit.present?}"
  end

  def incomes
    incomes = []
    if self.sale.present?
      incomes << self.sale.income
    elsif self.debt.present?
      self.debt.payments.each do |p|
        incomes << p.income
      end
    end
    incomes
  end

  def calculate_refund
    refund = 0
    currency = ""
    incomes.each do |i|
      refund += i.amount
      currency = i.currency
    end
    "#{refund} #{I18n.t! currency}"
  end

  def destroy_dependences
    if self.sale.present?
      self.sale.destroy
    elsif self.debt.present?
      self.debt.destroy
    end
    self.status = I18n.t! :on_sale
    self.save!
  end

  def amounts
    Hash[CURRENCIES.map { |c|
      [c, CURRENCIES.include?(currency.to_sym) ? amount : nil]
    }]
  end

  def price
    "#{amount} #{I18n.t!(currency) if currency.present?}"
  end

  def update_status
    if self.sale.present? or (self.debt.present? and self.debt.payed?)
      value = :payed
    elsif self.debt.present? and not self.debt.payed?
      value = :not_payed
    else
      value = :on_sale
    end
    self.status = I18n.t! value
    self.save!
  end

  def to_label
    menssage = "#{I18n.t :code}: #{jewelry_code}"
    if self.weight.present?
      menssage += ",  #{I18n.t :weight}: #{weight_and_measurement_unit}"
    end
    menssage
  end

end
