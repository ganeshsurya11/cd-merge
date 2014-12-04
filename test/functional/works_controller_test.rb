require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  setup do
    @work = works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post :create, work: { work_name: @work.work_name, work_notes: @work.work_notes, work_siglum: @work.work_siglum, work_viaf_id: @work.work_viaf_id, work_viaf_link: @work.work_viaf_link }
    end

    assert_redirected_to work_path(assigns(:work))
  end

  test "should show work" do
    get :show, id: @work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work
    assert_response :success
  end

  test "should update work" do
    put :update, id: @work, work: { work_name: @work.work_name, work_notes: @work.work_notes, work_siglum: @work.work_siglum, work_viaf_id: @work.work_viaf_id, work_viaf_link: @work.work_viaf_link }
    assert_redirected_to work_path(assigns(:work))
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete :destroy, id: @work
    end

    assert_redirected_to works_path
  end
end
