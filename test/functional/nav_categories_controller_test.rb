require 'test_helper'

class NavCategoriesControllerTest < ActionController::TestCase
  setup do
    @nav_category = nav_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nav_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nav_category" do
    assert_difference('NavCategory.count') do
      post :create, nav_category: { nav_category_name: @nav_category.nav_category_name, nav_category_order: @nav_category.nav_category_order }
    end

    assert_redirected_to nav_category_path(assigns(:nav_category))
  end

  test "should show nav_category" do
    get :show, id: @nav_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nav_category
    assert_response :success
  end

  test "should update nav_category" do
    put :update, id: @nav_category, nav_category: { nav_category_name: @nav_category.nav_category_name, nav_category_order: @nav_category.nav_category_order }
    assert_redirected_to nav_category_path(assigns(:nav_category))
  end

  test "should destroy nav_category" do
    assert_difference('NavCategory.count', -1) do
      delete :destroy, id: @nav_category
    end

    assert_redirected_to nav_categories_path
  end
end
