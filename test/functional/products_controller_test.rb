require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    any_instance_of(Product) do |p|
      stub(p).boxes {[boxes :one]}
    end
    assert_difference('Product.count') do
      post :create, :record => { :name => 'n' }
    end

    assert_redirected_to products_path
  end

  test "should show product" do
    get :show, :id => products(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => products(:one).to_param
    assert_response :success
  end

  test "should update product" do
    put :update, :id => products(:one).to_param, :record => {:name=>"dude", :boxes=>{"123"=>{:box_code=>"123", :description=>"123"}}}
    assert_redirected_to products_path
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => products(:one).to_param
    end

    assert_redirected_to products_path
  end
end
