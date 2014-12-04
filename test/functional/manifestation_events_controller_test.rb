require 'test_helper'

class ManifestationEventsControllerTest < ActionController::TestCase
  setup do
    @manifestation_event = manifestation_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:manifestation_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create manifestation_event" do
    assert_difference('ManifestationEvent.count') do
      post :create, manifestation_event: { agent_id: @manifestation_event.agent_id, event_type_id: @manifestation_event.event_type_id, location_id: @manifestation_event.location_id, manifestation_event_end_date: @manifestation_event.manifestation_event_end_date, manifestation_event_notes: @manifestation_event.manifestation_event_notes, manifestation_event_start_date: @manifestation_event.manifestation_event_start_date, manifestation_id: @manifestation_event.manifestation_id, role_id: @manifestation_event.role_id }
    end

    assert_redirected_to manifestation_event_path(assigns(:manifestation_event))
  end

  test "should show manifestation_event" do
    get :show, id: @manifestation_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @manifestation_event
    assert_response :success
  end

  test "should update manifestation_event" do
    put :update, id: @manifestation_event, manifestation_event: { agent_id: @manifestation_event.agent_id, event_type_id: @manifestation_event.event_type_id, location_id: @manifestation_event.location_id, manifestation_event_end_date: @manifestation_event.manifestation_event_end_date, manifestation_event_notes: @manifestation_event.manifestation_event_notes, manifestation_event_start_date: @manifestation_event.manifestation_event_start_date, manifestation_id: @manifestation_event.manifestation_id, role_id: @manifestation_event.role_id }
    assert_redirected_to manifestation_event_path(assigns(:manifestation_event))
  end

  test "should destroy manifestation_event" do
    assert_difference('ManifestationEvent.count', -1) do
      delete :destroy, id: @manifestation_event
    end

    assert_redirected_to manifestation_events_path
  end
end
