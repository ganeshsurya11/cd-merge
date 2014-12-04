require 'test_helper'

class LocalMarkupMappingsControllerTest < ActionController::TestCase
  setup do
    @local_markup_mapping = local_markup_mappings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:local_markup_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create local_markup_mapping" do
    assert_difference('LocalMarkupMapping.count') do
      post :create, local_markup_mapping: { local_markup_map_tei: @local_markup_mapping.local_markup_map_tei, local_markup_map_token: @local_markup_mapping.local_markup_map_token }
    end

    assert_redirected_to local_markup_mapping_path(assigns(:local_markup_mapping))
  end

  test "should show local_markup_mapping" do
    get :show, id: @local_markup_mapping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @local_markup_mapping
    assert_response :success
  end

  test "should update local_markup_mapping" do
    put :update, id: @local_markup_mapping, local_markup_mapping: { local_markup_map_tei: @local_markup_mapping.local_markup_map_tei, local_markup_map_token: @local_markup_mapping.local_markup_map_token }
    assert_redirected_to local_markup_mapping_path(assigns(:local_markup_mapping))
  end

  test "should destroy local_markup_mapping" do
    assert_difference('LocalMarkupMapping.count', -1) do
      delete :destroy, id: @local_markup_mapping
    end

    assert_redirected_to local_markup_mappings_path
  end
end
