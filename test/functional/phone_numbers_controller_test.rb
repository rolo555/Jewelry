require 'test_helper'

class PhoneNumbersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_number" do
    assert_difference('PhoneNumber.count') do
      post :create, :phone_number => { }
    end

    assert_redirected_to phone_number_path(assigns(:phone_number))
  end

  test "should show phone_number" do
    get :show, :id => phone_numbers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => phone_numbers(:one).to_param
    assert_response :success
  end

  test "should update phone_number" do
    put :update, :id => phone_numbers(:one).to_param, :phone_number => { }
    assert_redirected_to phone_number_path(assigns(:phone_number))
  end

  test "should destroy phone_number" do
    assert_difference('PhoneNumber.count', -1) do
      delete :destroy, :id => phone_numbers(:one).to_param
    end

    assert_redirected_to phone_numbers_path
  end
end
