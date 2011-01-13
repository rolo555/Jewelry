require 'test_helper'

class JewelriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jewelries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jewelry" do
    assert_difference('Jewelry.count') do
      post :create, :jewelry => { }
    end

    assert_redirected_to jewelry_path(assigns(:jewelry))
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
    put :update, :id => jewelries(:one).to_param, :jewelry => { }
    assert_redirected_to jewelry_path(assigns(:jewelry))
  end

  test "should destroy jewelry" do
    assert_difference('Jewelry.count', -1) do
      delete :destroy, :id => jewelries(:one).to_param
    end

    assert_redirected_to jewelries_path
  end
end
