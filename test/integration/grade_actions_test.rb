require 'test_helper'

class GradeActionsTest< ActionDispatch::IntegrationTest
  def setup
    @g1 = grades(:g1)
    @g2 = grades(:g2)
    @g3 = grades(:g3)
    @archer = users(:archer)
    @henn = users(:henn)
  end

  test "should redirect update when teacher not logged in" do
    patch grade_path(@g1, params: {grade: {grade: 60}} )
    assert_equal @g1.grade, @g1.reload.grade
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "update" do
    log_in_as(@archer)
    patch grade_path(@g1, params: {grade: {grade: 60}} )
    assert_not_equal @g1.grade, @g1.reload.grade
    assert_not flash.empty?
    assert_redirected_to grades_url
  end

  test "should redirect index when not logged in" do
    get grades_path
    assert_redirected_to root_url
  end

  test "should render current page when student logged in" do
    log_in_as(@henn)
    get grades_path
    assert_template 'grades/index'
  end


end