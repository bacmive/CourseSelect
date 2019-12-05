require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password:"foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.user_authenticated?(:remember,'')
  end

  test "create_reset_digest should create the reset_digest and reset_sent_at" do
    @user.reset_digest  = nil
    @user.reset_sent_at = nil
    @user.create_reset_digest
    assert_not_equal(@user.reset_digest,nil)
    assert_not_equal(@user.reset_sent_at,nil)
  end

  test "user_remember should create the remember_token and remember_digest" do
    @user.remember_token = nil
    @user.remember_digest= nil
    @user.user_remember
    assert_not_equal(@user.remember_token, nil)
    assert_not_equal(@user.remember_digest,nil)
  end

end
