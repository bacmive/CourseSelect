class UserLoginTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:cheech)
    @user1= users(:bacmive)
    @user2= users(:archer)
    @user3= users(:henn)
  end

  test "login with invalid information" do
    get sessions_login_path
    assert_template 'sessions/new'
    post sessions_login_path, params: { session: { email: "", password: "" } }
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "should not login without activation" do
    get sessions_login_path
    assert_template 'sessions/new'
    post sessions_login_path, params: { session: { email: @user3.email, password: "111111" } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "login with valid information(as for admin)" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user.email, password: '111111'}})
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", rails_admin_path, count: 1
  end

  test "login with valid information(as for non-admin)" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user1.email, password: '111111'}})
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", rails_admin_path, count: 0
  end

  test "login with valid information(as for teacher)" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user2.email, password: '111111'}})
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", rails_admin_path, count: 0
  end

  
  test "login with valid information followed by logout" do
    get sessions_login_path
    post sessions_login_path, params: { session: {email: @user.email, password: '111111'}}
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'homes/index'
    assert_select "a[href=?]", sessions_login_path, count: 0
    assert_select "a[href=?]", sessions_logout_path
    assert_select "a[href=?]", edit_user_path(@user)
    delete sessions_logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #simulation: click the logout_link in another label page
    delete sessions_logout_path
    follow_redirect!
    assert_select "a[href=?]", sessions_login_path
    assert_select "a[href=?]", sessions_logout_path, count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

  test "should not log out when not logged in" do
    delete sessions_logout_path
    assert_redirected_to root_url
  end

  test "should log out when logged in" do
    log_in_as(@user)
    delete sessions_logout_path
    assert_redirected_to root_url
  end


end