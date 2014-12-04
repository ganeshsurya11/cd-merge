require 'test_helper'

class HoldingInstitutionsControllerTest < ActionController::TestCase
  setup do
    @holding_institution = holding_institutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:holding_institutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create holding_institution" do
    assert_difference('HoldingInstitution.count') do
      post :create, holding_institution: { holding_institution_name: @holding_institution.holding_institution_name, holding_institution_notes: @holding_institution.holding_institution_notes, holding_institution_siglum: @holding_institution.holding_institution_siglum }
    end

    assert_redirected_to holding_institution_path(assigns(:holding_institution))
  end

  test "should show holding_institution" do
    get :show, id: @holding_institution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @holding_institution
    assert_response :success
  end

  test "should update holding_institution" do
    put :update, id: @holding_institution, holding_institution: { holding_institution_name: @holding_institution.holding_institution_name, holding_institution_notes: @holding_institution.holding_institution_notes, holding_institution_siglum: @holding_institution.holding_institution_siglum }
    assert_redirected_to holding_institution_path(assigns(:holding_institution))
  end

  test "should destroy holding_institution" do
    assert_difference('HoldingInstitution.count', -1) do
      delete :destroy, id: @holding_institution
    end

    assert_redirected_to holding_institutions_path
  end
end
