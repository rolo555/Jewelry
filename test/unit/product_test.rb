require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "before create should set product_auto_code to zero" do
    product = Product.new
    product.before_create
    assert_equal 0, product.product_auto_code
  end

  test "increase product_auto_code" do
    product = products :one
    assert_difference "product.product_auto_code" do
      product.increase_product_auto_code
    end
  end
end
