require 'test_helper'

class DigitalEditionsControllerTest < ActionController::TestCase
  setup do
    @digital_edition = digital_editions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:digital_editions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create digital_edition" do
    assert_difference('DigitalEdition.count') do
      post :create, digital_edition: { digital_edition_active: @digital_edition.digital_edition_active, digital_edition_description: @digital_edition.digital_edition_description, digital_edition_local_title: @digital_edition.digital_edition_local_title, digital_edition_notes: @digital_edition.digital_edition_notes }
    end

    assert_redirected_to digital_edition_path(assigns(:digital_edition))
  end

  test "should show digital_edition" do
    get :show, id: @digital_edition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @digital_edition
    assert_response :success
  end

  test "should update digital_edition" do
    put :update, id: @digital_edition, digital_edition: { digital_edition_active: @digital_edition.digital_edition_active, digital_edition_description: @digital_edition.digital_edition_description, digital_edition_local_title: @digital_edition.digital_edition_local_title, digital_edition_notes: @digital_edition.digital_edition_notes }
    assert_redirected_to digital_edition_path(assigns(:digital_edition))
  end

  test "should destroy digital_edition" do
    assert_difference('DigitalEdition.count', -1) do
      delete :destroy, id: @digital_edition
    end

    assert_redirected_to digital_editions_path
  end
end
