require 'test_helper'

class ExpressionTypesControllerTest < ActionController::TestCase
  setup do
    @expression_type = expression_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expression_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expression_type" do
    assert_difference('ExpressionType.count') do
      post :create, expression_type: { expression_type_description: @expression_type.expression_type_description, expression_type_note: @expression_type.expression_type_note, expression_type_type: @expression_type.expression_type_type }
    end

    assert_redirected_to expression_type_path(assigns(:expression_type))
  end

  test "should show expression_type" do
    get :show, id: @expression_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expression_type
    assert_response :success
  end

  test "should update expression_type" do
    put :update, id: @expression_type, expression_type: { expression_type_description: @expression_type.expression_type_description, expression_type_note: @expression_type.expression_type_note, expression_type_type: @expression_type.expression_type_type }
    assert_redirected_to expression_type_path(assigns(:expression_type))
  end

  test "should destroy expression_type" do
    assert_difference('ExpressionType.count', -1) do
      delete :destroy, id: @expression_type
    end

    assert_redirected_to expression_types_path
  end
end
