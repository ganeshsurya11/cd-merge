require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    @location = locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, location: { location_ghetty_id: @location.location_ghetty_id, location_ghetty_name: @location.location_ghetty_name, location_latitude: @location.location_latitude, location_longitude: @location.location_longitude, location_name: @location.location_name, location_notes: @location.location_notes }
    end

    assert_redirected_to location_path(assigns(:location))
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location
    assert_response :success
  end

  test "should update location" do
    put :update, id: @location, location: { location_ghetty_id: @location.location_ghetty_id, location_ghetty_name: @location.location_ghetty_name, location_latitude: @location.location_latitude, location_longitude: @location.location_longitude, location_name: @location.location_name, location_notes: @location.location_notes }
    assert_redirected_to location_path(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to locations_path
  end
end
