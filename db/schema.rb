# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140809103215) do

  create_table "agents", :force => true do |t|
    t.string   "agent_last_name"
    t.string   "agent_first_name"
    t.string   "agent_middle_name"
    t.string   "agent_name_prefix"
    t.string   "agent_name_suffix"
    t.integer  "agent_birth_year"
    t.integer  "agent_death_year"
    t.integer  "agent_viaf_id"
    t.string   "agent_viaf_link"
    t.string   "agent_viaf_type"
    t.text     "agent_notes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "concordance_entries", :force => true do |t|
    t.string   "concordance_entry_token"
    t.boolean  "concordance_stop"
    t.integer  "concordance_entry_total"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "concordance_entries", ["concordance_entry_token"], :name => "index_concordance_entries_on_concordance_entry_token"

  create_table "concordance_stop_words", :force => true do |t|
    t.string   "stop_word_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "confs", :force => true do |t|
    t.boolean  "config_active"
    t.boolean  "conf_group_expression_type"
    t.boolean  "conf_group_manifestation_type"
    t.boolean  "conf_build_concordance"
    t.boolean  "conf_build_variants"
    t.string   "conf_contact_email"
    t.boolean  "conf_contact_form"
    t.string   "conf_site_name"
    t.string   "conf_site_tagline"
    t.string   "conf_site_domain_name"
    t.string   "conf_site_httpd_root"
    t.string   "conf_site_transcription_root"
    t.string   "conf_site_facsimile_root"
    t.string   "conf_site_xslt_directory"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "conf_publisher"
    t.string   "conf_publisher_url"
    t.string   "conf_publisher_location"
    t.text     "conf_publisher_license"
    t.string   "conf_site_editor_name"
    t.text     "conf_splash"
  end

  create_table "digital_edition_has_concordance_entries", :force => true do |t|
    t.integer  "concordance_entry_id"
    t.integer  "line_id"
    t.integer  "digital_edition_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "digital_edition_has_concordance_entry_totals", :force => true do |t|
    t.integer  "concordance_entry_id"
    t.integer  "digital_edition_id"
    t.integer  "entrycount"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "digital_editions", :force => true do |t|
    t.string   "digital_edition_local_title"
    t.string   "digital_edition_description"
    t.boolean  "digital_edition_active"
    t.text     "digital_edition_notes"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "manifestation_id"
    t.integer  "nav_category_id"
    t.integer  "digital_edition_order"
    t.integer  "item_id"
    t.string   "digital_edition_variant_list_url"
  end

  create_table "edition_teis", :force => true do |t|
    t.integer  "digital_edition_id"
    t.text     "tei_build_tei"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "event_type_type"
    t.string   "event_type_description"
    t.text     "event_type_notes"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "expression_types", :force => true do |t|
    t.string   "expression_type_type"
    t.string   "expression_type_description"
    t.text     "expression_type_note"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "expressions", :force => true do |t|
    t.integer  "expression_type_id"
    t.string   "expression_name"
    t.string   "expression_siglum"
    t.string   "expression_description"
    t.text     "expression_notes"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "work_id"
  end

  create_table "expressions_has_manifestations", :force => true do |t|
    t.integer  "expression_id"
    t.integer  "manifestation_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "expression_has_manifestation_primary"
  end

  create_table "holding_institutions", :force => true do |t|
    t.string   "holding_institution_name"
    t.string   "holding_institution_siglum"
    t.text     "holding_institution_notes"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "item_events", :force => true do |t|
    t.integer  "item_id"
    t.integer  "event_type_id"
    t.integer  "location_id"
    t.string   "item_event_start_date"
    t.string   "item_event_end_date"
    t.text     "item_event_notes"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "item_events_has_agents", :force => true do |t|
    t.integer  "item_event_id"
    t.integer  "agent_id"
    t.integer  "role_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "manifestation_id"
    t.integer  "holding_institution_id"
    t.string   "item_siglum"
    t.string   "item_description"
    t.string   "item_shelfmark"
    t.text     "item_notes"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "items_has_digital_editions", :force => true do |t|
    t.integer  "item_id"
    t.integer  "digital_edition_id"
    t.boolean  "item_has_digital_edition_primary"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "lines", :force => true do |t|
    t.integer  "page_id"
    t.integer  "transcription_id"
    t.integer  "line_page_order"
    t.string   "line_tei"
    t.string   "line_plaintext"
    t.string   "line_variant_version"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "work_id"
    t.integer  "expression_id"
    t.integer  "digital_edition_id"
    t.integer  "line_expression_order"
    t.string   "line_designator"
    t.string   "line_dv_start_code"
    t.integer  "line_digital_edition_order"
  end

  create_table "local_markup_mappings", :force => true do |t|
    t.string   "local_markup_map_token"
    t.string   "local_markup_map_tei"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "location_name"
    t.string   "location_ghetty_name"
    t.text     "location_notes"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "location_latitude"
    t.string   "location_longitude"
    t.string   "location_ghetty_id"
  end

  create_table "manifestation_events", :force => true do |t|
    t.integer  "manifestation_id"
    t.integer  "event_type_id"
    t.integer  "location_id"
    t.string   "manifestation_event_start_date"
    t.string   "manifestation_event_end_date"
    t.text     "manifestation_event_notes"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "manifestation_events_has_agents", :force => true do |t|
    t.integer  "manifestation_event_id"
    t.integer  "agent_id"
    t.integer  "role_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "manifestation_types", :force => true do |t|
    t.string   "manifestation_type_type"
    t.string   "manifestation_type_description"
    t.text     "manifestation_type_notes"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "manifestations", :force => true do |t|
    t.integer  "manifestation_type_id"
    t.string   "manifestation_name"
    t.string   "manifestation_siglum"
    t.string   "manifestation_description"
    t.text     "manifestation_notes"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "nav_categories", :force => true do |t|
    t.string   "nav_category_name"
    t.integer  "nav_category_order"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "pages", :force => true do |t|
    t.integer  "page_page"
    t.string   "page_image"
    t.text     "page_notes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "digital_edition_id"
    t.text     "page_tei"
  end

  create_table "roles", :force => true do |t|
    t.string   "role_role"
    t.string   "role_description"
    t.text     "role_notes"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "surrogates", :force => true do |t|
    t.integer  "item_id"
    t.string   "surrogate_local_title"
    t.string   "surrogate_local_description"
    t.boolean  "surrogate_active"
    t.text     "surrogate_notes"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "system_event_types", :force => true do |t|
    t.string   "system_event_type_type"
    t.text     "system_event_type_notes"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "transcriptions", :force => true do |t|
    t.integer  "page_id"
    t.integer  "transcription_order"
    t.string   "transcription_file"
    t.text     "transcription_text"
    t.text     "transcription_tei"
    t.text     "transcription_notes"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "work_id"
    t.integer  "expression_id"
    t.integer  "digital_edition_id"
  end

  create_table "user_roles", :force => true do |t|
    t.string   "user_roles_role"
    t.text     "user_roles_notes"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "vc_concordance_stop_words", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_stop_word_token"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "vc_entities", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_entity_name"
    t.string   "vc_entity_siglum"
    t.integer  "vc_entity_viaf_work_id"
    t.string   "vc_entity_viaf_work_link"
    t.string   "vc_entity_standard_title"
    t.string   "vc_entity_standard_title_source"
    t.text     "vc_entity_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "vc_event_types", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_event_type_type"
    t.string   "vc_event_type_description"
    t.text     "vc_event_type_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "vc_expression_types", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_expression_type_type"
    t.string   "vc_expression_type_description"
    t.string   "vc_expression_type_note"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "vc_expressions", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_expression_name"
    t.string   "vc_expression_siglum"
    t.string   "vc_expression_description"
    t.text     "vc_expression_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "vc_holding_institutions", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_holding_institution_name"
    t.string   "vc_holding_institution_siglum"
    t.text     "vc_holding_institution_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "vc_item_events", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_item_id"
    t.integer  "vc_event_type_id"
    t.integer  "vc_agent_id"
    t.integer  "vc_role_id"
    t.integer  "vc_location_id"
    t.integer  "vc_Item_event_year"
    t.integer  "vc_Item_event_month"
    t.integer  "vc_Item_event_day"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "vc_items", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_manifestation_id"
    t.integer  "vc_holding_institution_id"
    t.string   "vc_item_siglum"
    t.string   "vc_item_description"
    t.string   "vc_item_shelfmark"
    t.text     "vc_item_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "vc_lines", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_page_id"
    t.integer  "vc_surrogate_id"
    t.integer  "vc_entities_id"
    t.integer  "vc_line_page_order"
    t.integer  "vc_line_entity_order"
    t.string   "vc_line_tei"
    t.string   "vc_line_plaintext"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "vc_locations", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_location_name"
    t.decimal  "vc_location_latitude"
    t.decimal  "vc_location_longitude"
    t.string   "vc_location_ghetty_name"
    t.integer  "vc_location_ghetty_id"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "vc_manifestation_types", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_manifestation_type_type"
    t.string   "vc_manifestation_type_description"
    t.text     "vc_manifestation_type_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "vc_manifestations", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_expression_id"
    t.integer  "vc_manifestation_type_id"
    t.string   "vc_manifestation_title"
    t.string   "vc_manifestation_siglum"
    t.string   "vc_manifestation_description"
    t.text     "vc_manifestation_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "vc_pages", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_page_page"
    t.string   "vc_page_image"
    t.text     "vc_page_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "vc_roles", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_role_role"
    t.text     "vc_role_ntoes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "vc_transcriptions", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_page_id"
    t.integer  "vc_item_id"
    t.integer  "vc_entitiy_id"
    t.integer  "vc_transcription_order"
    t.string   "vc_transcription_file"
    t.text     "vc_transcription_text"
    t.text     "vc_transcription_tei"
    t.text     "vc_transcription_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "vc_works", :force => true do |t|
    t.integer  "vc_id"
    t.string   "vc_work_name"
    t.string   "vc_work_siglum"
    t.integer  "vc_work_viaf_id"
    t.string   "vc_work_viaf_link"
    t.text     "vc_work_notes"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "vc_works_has_expressions", :force => true do |t|
    t.integer  "vc_id"
    t.integer  "vc_work_id"
    t.integer  "vc_expression_id"
    t.integer  "vc_user_id"
    t.string   "vc_user_name"
    t.string   "vc_user_action"
    t.datetime "vc_date_time_stamp"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "works", :force => true do |t|
    t.string   "work_name"
    t.string   "work_siglum"
    t.integer  "work_viaf_id"
    t.string   "work_viaf_link"
    t.text     "work_notes"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.boolean  "work_frbr"
    t.string   "work_standard_title"
    t.string   "work_standard_title_source"
    t.string   "work_short_code"
  end

end
