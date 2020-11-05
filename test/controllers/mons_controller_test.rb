require 'test_helper'

class MonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mon = mons(:one)
  end

  test "should get index" do
    get mons_url
    assert_response :success
  end

  test "should get new" do
    get new_mon_url
    assert_response :success
  end

  test "should create mon" do
    assert_difference('Mon.count') do
      post mons_url, params: { mon: { abilities: @mon.abilities, name: @mon.name } }
    end

    assert_redirected_to mon_url(Mon.last)
  end

  test "should show mon" do
    get mon_url(@mon)
    assert_response :success
  end

  test "should get edit" do
    get edit_mon_url(@mon)
    assert_response :success
  end

  test "should update mon" do
    patch mon_url(@mon), params: { mon: { abilities: @mon.abilities, name: @mon.name } }
    assert_redirected_to mon_url(@mon)
  end

  test "should destroy mon" do
    assert_difference('Mon.count', -1) do
      delete mon_url(@mon)
    end

    assert_redirected_to mons_url
  end
end
