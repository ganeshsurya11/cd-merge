require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { expression_id: @item.expression_id, holding_institutions_id: @item.holding_institutions_id, item_description: @item.item_description, item_notes: @item.item_notes, item_shelfmark: @item.item_shelfmark, item_siglum: @item.item_siglum, manifestation_id: @item.manifestation_id }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    put :update, id: @item, item: { expression_id: @item.expression_id, holding_institutions_id: @item.holding_institutions_id, item_description: @item.item_description, item_notes: @item.item_notes, item_shelfmark: @item.item_shelfmark, item_siglum: @item.item_siglum, manifestation_id: @item.manifestation_id }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
