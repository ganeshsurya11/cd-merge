require 'test_helper'

class ConfsControllerTest < ActionController::TestCase
  setup do
    @conf = confs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conf" do
    assert_difference('Conf.count') do
      post :create, conf: { conf_build_concordance: @conf.conf_build_concordance, conf_build_variants: @conf.conf_build_variants, conf_contact_email: @conf.conf_contact_email, conf_contact_form: @conf.conf_contact_form, conf_group_expression_type: @conf.conf_group_expression_type, conf_group_manifestation_type: @conf.conf_group_manifestation_type, conf_site_domain_name: @conf.conf_site_domain_name, conf_site_facsimile_root: @conf.conf_site_facsimile_root, conf_site_httpd_root: @conf.conf_site_httpd_root, conf_site_name: @conf.conf_site_name, conf_site_tagline: @conf.conf_site_tagline, conf_site_transcription_root: @conf.conf_site_transcription_root, conf_site_xslt_directory: @conf.conf_site_xslt_directory, config_active: @conf.config_active }
    end

    assert_redirected_to conf_path(assigns(:conf))
  end

  test "should show conf" do
    get :show, id: @conf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conf
    assert_response :success
  end

  test "should update conf" do
    put :update, id: @conf, conf: { conf_build_concordance: @conf.conf_build_concordance, conf_build_variants: @conf.conf_build_variants, conf_contact_email: @conf.conf_contact_email, conf_contact_form: @conf.conf_contact_form, conf_group_expression_type: @conf.conf_group_expression_type, conf_group_manifestation_type: @conf.conf_group_manifestation_type, conf_site_domain_name: @conf.conf_site_domain_name, conf_site_facsimile_root: @conf.conf_site_facsimile_root, conf_site_httpd_root: @conf.conf_site_httpd_root, conf_site_name: @conf.conf_site_name, conf_site_tagline: @conf.conf_site_tagline, conf_site_transcription_root: @conf.conf_site_transcription_root, conf_site_xslt_directory: @conf.conf_site_xslt_directory, config_active: @conf.config_active }
    assert_redirected_to conf_path(assigns(:conf))
  end

  test "should destroy conf" do
    assert_difference('Conf.count', -1) do
      delete :destroy, id: @conf
    end

    assert_redirected_to confs_path
  end
end
