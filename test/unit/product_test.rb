require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "increase product_auto_code" do
    product = products :one
    assert_difference "product.product_auto_code" do
      product.increase_product_auto_code
    end
  end
end
