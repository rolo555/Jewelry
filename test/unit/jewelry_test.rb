require 'test_helper'

class JewelryTest < ActiveSupport::TestCase
  test "jewelry should have product_auto_code" do
    jewelry = Jewelry.new :product_auto_code => 123
    assert_equal 123, jewelry.product_auto_code
  end

  test "after save jewelry should copy its box.product.product_auto_code" do
    jewelry = jewelries :one
    product_auto_code = jewelry.box.product.product_auto_code
    jewelry.save
    assert_equal product_auto_code, jewelry.product_auto_code
  end

  test "after save jewelry should call product.increase_product_auto_code" do
    jewelry = jewelries :one
    stub(jewelry.box.product).increase_product_auto_code
    jewelry.save
    assert_received(jewelry.box.product) {|subject| subject.increase_product_auto_code}
  end
end
