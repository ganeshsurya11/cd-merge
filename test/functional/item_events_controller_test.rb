require 'test_helper'

class ItemEventsControllerTest < ActionController::TestCase
  setup do
    @item_event = item_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_event" do
    assert_difference('ItemEvent.count') do
      post :create, item_event: { agent_id: @item_event.agent_id, event_type_id: @item_event.event_type_id, item_event_end_date: @item_event.item_event_end_date, item_event_notes: @item_event.item_event_notes, item_event_start_date: @item_event.item_event_start_date, item_id: @item_event.item_id, location_id: @item_event.location_id, role_id: @item_event.role_id }
    end

    assert_redirected_to item_event_path(assigns(:item_event))
  end

  test "should show item_event" do
    get :show, id: @item_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_event
    assert_response :success
  end

  test "should update item_event" do
    put :update, id: @item_event, item_event: { agent_id: @item_event.agent_id, event_type_id: @item_event.event_type_id, item_event_end_date: @item_event.item_event_end_date, item_event_notes: @item_event.item_event_notes, item_event_start_date: @item_event.item_event_start_date, item_id: @item_event.item_id, location_id: @item_event.location_id, role_id: @item_event.role_id }
    assert_redirected_to item_event_path(assigns(:item_event))
  end

  test "should destroy item_event" do
    assert_difference('ItemEvent.count', -1) do
      delete :destroy, id: @item_event
    end

    assert_redirected_to item_events_path
  end
end
