require 'test_helper'

class ConcordanceEntriesControllerTest < ActionController::TestCase
  setup do
    @concordance_entry = concordance_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concordance_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concordance_entry" do
    assert_difference('ConcordanceEntry.count') do
      post :create, concordance_entry: { concordance_entry_token: @concordance_entry.concordance_entry_token, concordance_entry_total: @concordance_entry.concordance_entry_total, concordance_stop: @concordance_entry.concordance_stop }
    end

    assert_redirected_to concordance_entry_path(assigns(:concordance_entry))
  end

  test "should show concordance_entry" do
    get :show, id: @concordance_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @concordance_entry
    assert_response :success
  end

  test "should update concordance_entry" do
    put :update, id: @concordance_entry, concordance_entry: { concordance_entry_token: @concordance_entry.concordance_entry_token, concordance_entry_total: @concordance_entry.concordance_entry_total, concordance_stop: @concordance_entry.concordance_stop }
    assert_redirected_to concordance_entry_path(assigns(:concordance_entry))
  end

  test "should destroy concordance_entry" do
    assert_difference('ConcordanceEntry.count', -1) do
      delete :destroy, id: @concordance_entry
    end

    assert_redirected_to concordance_entries_path
  end
end
