require 'test_helper'

class ManifestationTypesControllerTest < ActionController::TestCase
  setup do
    @manifestation_type = manifestation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manifestation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manifestation_type" do
    assert_difference('ManifestationType.count') do
      post :create, manifestation_type: { manifestation_type_description: @manifestation_type.manifestation_type_description, manifestation_type_notes: @manifestation_type.manifestation_type_notes, manifestation_type_type: @manifestation_type.manifestation_type_type }
    end

    assert_redirected_to manifestation_type_path(assigns(:manifestation_type))
  end

  test "should show manifestation_type" do
    get :show, id: @manifestation_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manifestation_type
    assert_response :success
  end

  test "should update manifestation_type" do
    put :update, id: @manifestation_type, manifestation_type: { manifestation_type_description: @manifestation_type.manifestation_type_description, manifestation_type_notes: @manifestation_type.manifestation_type_notes, manifestation_type_type: @manifestation_type.manifestation_type_type }
    assert_redirected_to manifestation_type_path(assigns(:manifestation_type))
  end

  test "should destroy manifestation_type" do
    assert_difference('ManifestationType.count', -1) do
      delete :destroy, id: @manifestation_type
    end

    assert_redirected_to manifestation_types_path
  end
end
