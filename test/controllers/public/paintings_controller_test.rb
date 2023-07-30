require "test_helper"

class Public::PaintingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_paintings_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_paintings_edit_url
    assert_response :success
  end

  test "should get show" do
    get public_paintings_show_url
    assert_response :success
  end
end
