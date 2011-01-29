require 'test_helper'

class JewelryTest < ActiveSupport::TestCase
  test "jewelry should have product_auto_code" do
    jewelry = Jewelry.new :product_auto_code => 123
    assert_equal 123, jewelry.product_auto_code
  end
end
