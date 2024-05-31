require "test_helper"

class HivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hive = hives(:one)
  end

  test "should get index" do
    get hives_url, as: :json
    assert_response :success
  end

  test "should create hive" do
    assert_difference("Hive.count") do
      post hives_url, params: { hive: { name: @hive.name + '1', weight: @hive.weight } }, as: :json
    end

    assert_response :created
  end

  test "should not create hive with a short (<6) name field" do
    assert_no_difference("Hive.count") do
      post hives_url, params: { hive: { name: 'short', weight: @hive.weight } }, as: :json
    end

    assert_response(422)
  end

  test "should show hive" do
    get hive_url(@hive), as: :json
    assert_response :success
  end
end
