require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:cheech)
    @other_user = users(:archer)
  end

  test "show actions should work" do
    get user_path(@user)
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should editable when logged in" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_response :success
  end

  test "should updatable when logged in" do
    log_in_as(@user)
    patch user_path(@user), params: {user:{ name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end


  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
