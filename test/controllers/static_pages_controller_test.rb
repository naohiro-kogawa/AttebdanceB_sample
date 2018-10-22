require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "we love coffee"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "おすすめコーヒー店 | we love coffee"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "このサイトについて | we love coffee"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "管理人紹介 | we love coffee"
  end
end