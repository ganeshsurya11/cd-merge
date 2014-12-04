require 'test_helper'

class AgentsControllerTest < ActionController::TestCase
  setup do
    @agent = agents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agent" do
    assert_difference('Agent.count') do
      post :create, agent: { agent_birth_year: @agent.agent_birth_year, agent_death_year: @agent.agent_death_year, agent_first_name: @agent.agent_first_name, agent_last_name: @agent.agent_last_name, agent_middle_name: @agent.agent_middle_name, agent_name_prefix: @agent.agent_name_prefix, agent_name_suffix: @agent.agent_name_suffix, agent_notes: @agent.agent_notes, agent_viaf_id: @agent.agent_viaf_id, agent_viaf_link: @agent.agent_viaf_link, agent_viaf_type: @agent.agent_viaf_type }
    end

    assert_redirected_to agent_path(assigns(:agent))
  end

  test "should show agent" do
    get :show, id: @agent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agent
    assert_response :success
  end

  test "should update agent" do
    put :update, id: @agent, agent: { agent_birth_year: @agent.agent_birth_year, agent_death_year: @agent.agent_death_year, agent_first_name: @agent.agent_first_name, agent_last_name: @agent.agent_last_name, agent_middle_name: @agent.agent_middle_name, agent_name_prefix: @agent.agent_name_prefix, agent_name_suffix: @agent.agent_name_suffix, agent_notes: @agent.agent_notes, agent_viaf_id: @agent.agent_viaf_id, agent_viaf_link: @agent.agent_viaf_link, agent_viaf_type: @agent.agent_viaf_type }
    assert_redirected_to agent_path(assigns(:agent))
  end

  test "should destroy agent" do
    assert_difference('Agent.count', -1) do
      delete :destroy, id: @agent
    end

    assert_redirected_to agents_path
  end
end
