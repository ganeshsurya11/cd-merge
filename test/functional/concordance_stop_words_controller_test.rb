require 'test_helper'

class ConcordanceStopWordsControllerTest < ActionController::TestCase
  setup do
    @concordance_stop_word = concordance_stop_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concordance_stop_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concordance_stop_word" do
    assert_difference('ConcordanceStopWord.count') do
      post :create, concordance_stop_word: { stop_word_token: @concordance_stop_word.stop_word_token }
    end

    assert_redirected_to concordance_stop_word_path(assigns(:concordance_stop_word))
  end

  test "should show concordance_stop_word" do
    get :show, id: @concordance_stop_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @concordance_stop_word
    assert_response :success
  end

  test "should update concordance_stop_word" do
    put :update, id: @concordance_stop_word, concordance_stop_word: { stop_word_token: @concordance_stop_word.stop_word_token }
    assert_redirected_to concordance_stop_word_path(assigns(:concordance_stop_word))
  end

  test "should destroy concordance_stop_word" do
    assert_difference('ConcordanceStopWord.count', -1) do
      delete :destroy, id: @concordance_stop_word
    end

    assert_redirected_to concordance_stop_words_path
  end
end
