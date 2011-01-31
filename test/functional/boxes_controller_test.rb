require 'test_helper'

class BoxesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create box" do
    assert_difference('Box.count') do
      post :create, :record => { :box_code => '9', :description => 'Box nine' }
    end

    assert_redirected_to boxes_path
  end

  test "should show box" do
    get :show, :id => boxes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => boxes(:one).to_param
    assert_response :success
  end

  test "should update box" do
    put :update, :id => boxes(:one).to_param, :record => { }
    assert_redirected_to boxes_path
  end

  test "should destroy box" do
    assert_difference('Box.count', -1) do
      delete :destroy, :id => boxes(:one).to_param
    end

    assert_redirected_to boxes_path
  end
end
