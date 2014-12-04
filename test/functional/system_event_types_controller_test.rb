require 'test_helper'

class SystemEventTypesControllerTest < ActionController::TestCase
  setup do
    @system_event_type = system_event_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_event_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_event_type" do
    assert_difference('SystemEventType.count') do
      post :create, system_event_type: { system_event_type_notes: @system_event_type.system_event_type_notes, system_event_type_type: @system_event_type.system_event_type_type }
    end

    assert_redirected_to system_event_type_path(assigns(:system_event_type))
  end

  test "should show system_event_type" do
    get :show, id: @system_event_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_event_type
    assert_response :success
  end

  test "should update system_event_type" do
    put :update, id: @system_event_type, system_event_type: { system_event_type_notes: @system_event_type.system_event_type_notes, system_event_type_type: @system_event_type.system_event_type_type }
    assert_redirected_to system_event_type_path(assigns(:system_event_type))
  end

  test "should destroy system_event_type" do
    assert_difference('SystemEventType.count', -1) do
      delete :destroy, id: @system_event_type
    end

    assert_redirected_to system_event_types_path
  end
end
