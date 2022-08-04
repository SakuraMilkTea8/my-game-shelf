require "test_helper"

class ListGamesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get list_games_create_url
    assert_response :success
  end

  test "should get destroy" do
    get list_games_destroy_url
    assert_response :success
  end
end
