require 'test_helper'

class DocumentationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documentations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create documentation" do
    assert_difference('Documentation.count') do
      post :create, :documentation => { }
    end

    assert_redirected_to documentation_path(assigns(:documentation))
  end

  test "should show documentation" do
    get :show, :id => documentations(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => documentations(:one).id
    assert_response :success
  end

  test "should update documentation" do
    put :update, :id => documentations(:one).id, :documentation => { }
    assert_redirected_to documentation_path(assigns(:documentation))
  end

  test "should destroy documentation" do
    assert_difference('Documentation.count', -1) do
      delete :destroy, :id => documentations(:one).id
    end

    assert_redirected_to documentations_path
  end
end
