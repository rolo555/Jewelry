require 'test_helper'

class JewelriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jewelry" do
    any_instance_of(Jewelry) do |j|
      stub(j).box {boxes :one}
    end
    assert_difference('Jewelry.count') do
      post :create, :record => { :weight => '100', :purchase_date => '2011-01-31', :purchase_price => '100' }
    end

    assert_redirected_to jewelries_path
  end

  test "should show jewelry" do
    get :show, :id => jewelries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jewelries(:one).to_param
    assert_response :success
  end

  test "should update jewelry" do
    put :update, :id => jewelries(:one).to_param, :record => { }
    assert_redirected_to jewelries_path
  end

  test "should destroy jewelry" do
    assert_difference('Jewelry.count', -1) do
      delete :destroy, :id => jewelries(:one).to_param
    end

    assert_redirected_to jewelries_path
  end
end
