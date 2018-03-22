require 'test_helper'

class HerosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hero = heros(:one)
  end

  test "should get index" do
    get heros_url
    assert_response :success
  end

  test "should get new" do
    get new_hero_url
    assert_response :success
  end

  test "should create hero" do
    assert_difference('Hero.count') do
      post heros_url, params: { hero: { atk: @hero.atk, def: @hero.def, hp: @hero.hp, name: @hero.name, speed: @hero.speed, type: @hero.type, user_id: @hero.user_id } }
    end

    assert_redirected_to hero_url(Hero.last)
  end

  test "should show hero" do
    get hero_url(@hero)
    assert_response :success
  end

  test "should get edit" do
    get edit_hero_url(@hero)
    assert_response :success
  end

  test "should update hero" do
    patch hero_url(@hero), params: { hero: { atk: @hero.atk, def: @hero.def, hp: @hero.hp, name: @hero.name, speed: @hero.speed, type: @hero.type, user_id: @hero.user_id } }
    assert_redirected_to hero_url(@hero)
  end

  test "should destroy hero" do
    assert_difference('Hero.count', -1) do
      delete hero_url(@hero)
    end

    assert_redirected_to heros_url
  end
end
