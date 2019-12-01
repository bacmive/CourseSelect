class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:cheech)
  end

  test "login with valid information" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user.email, password: '111111'}})
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", rails_admin_path, count: 0
  end

end