require "test_helper"

class Admin::PaintingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_paintings_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_paintings_show_url
    assert_response :success
  end
end
