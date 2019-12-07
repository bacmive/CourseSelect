require 'test_helper'
class CourseActionsTest < ActionDispatch::IntegrationTest
  def setup
    @yuwen = courses(:yuwen)
    @shuxue= courses(:shuxue)
    @wuli= courses(:wuli)
    @teacher=users(:archer)
    @teacher2=users(:zhang)
    @bacmive = users(:bacmive)
  end

  test "should redirect to root_url when not logged in " do
    get new_course_path
    assert_no_difference 'Course.count' do
      post courses_path, params: {course: {name: "yuwen", 
                                          course_type: "obligatory",
                                          course_time: "everyday",
                                          course_week: "everyweek",
                                          class_room: "memory",
                                          credit: "youbet",
                                          teaching_type: "teaching",
                                          exam_type: "kaoshi",
                                          teacher: "zhang"}}
    end
    assert_redirected_to root_url
  end
 
  test "should redirect to root_url when not logged in" do
    assert_no_difference 'Course.count' do
      delete course_path(@yuwen)
    end
    assert_redirected_to root_url
  end

  test "should work when teacher logged in" do
    log_in_as(@teacher)
    get new_course_path
    assert_difference 'Course.count', 1 do
      post courses_path, params: {course: {name: "yingyu", course_type: "obligatory",
                                          course_time: "everyday", course_week: "everyweek",
                                          class_room: "memory",credit: "youbet",
                                          teaching_type: "teaching",exam_type: "kaoshi",
                                          limit_num:500}}
    end
    assert_not flash.empty?
    assert_redirected_to courses_path
    #assert_redirected_to root_url
  end

  test "should not modify the course when not logged in" do
    get edit_course_path(@shuxue)
    patch course_path(@shuxue, params: {course: {name: "shuxue", course_type: "obligatory",
                                          course_time: "everyday", course_week: "everyweek",
                                          class_room: "memory",credit: "Iguess",
                                          teaching_type: "teaching",exam_type: "kaoshi",
                                          limit_num:500}})
    assert_equal @shuxue.credit, @shuxue.reload.credit
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should modify the course when logged in as correct user" do
    log_in_as(@teacher2)
    get edit_course_path(@shuxue)
    patch course_path(@shuxue, params: {course: {name: "shuxue", course_type: "obligatory",
                                          course_time: "everyday", course_week: "everyweek",
                                          class_room: "memory",credit: "Iguess",
                                          teaching_type: "teaching",exam_type: "kaoshi",
                                          limit_num:500}})
    assert_no_match @shuxue, @shuxue.reload
    assert_not flash.empty?
    assert_redirected_to courses_path
  end

  test "should open course when teacher logged in" do
    log_in_as(@teacher)
    get open_course_path(@yuwen)
    assert_not_equal @yuwen.open, @yuwen.reload.open
    assert_not flash.empty?
    assert_redirected_to courses_path
  end

  test "should close course when teacher logged in" do
    log_in_as(@teacher)
    get close_course_path(@yuwen)
    assert_equal @yuwen.open, @yuwen.reload.open
    assert_not flash.empty?
    assert_redirected_to courses_path
  end

  test "should redirect courses_page when teacher logged in" do
    log_in_as(@teacher)
    assert_difference 'Course.count', -1 do
      delete course_path(@yuwen)
    end
    assert_not flash.empty?
    assert_redirected_to courses_path
  end

  test "should redirect list when not logged in" do
    get list_courses_path
    assert_redirected_to root_url
  end

  test "should render available courses when logged in" do
    log_in_as(users(:bacmive))
    get list_courses_path
    assert_template 'courses/list'
  end

  test "select courses" do
    log_in_as(@bacmive)
    assert_empty @bacmive.courses
    get select_course_path(@wuli)
    assert_not_empty @bacmive.courses
    assert_not flash.empty?
    assert_redirected_to courses_path
  end

  test "quit courses" do
    log_in_as(@bacmive)
    get select_course_path(@wuli)
    assert_not_empty @bacmive.courses
    get quit_course_path(@wuli)
    assert_empty @bacmive.courses
    assert_not flash.empty?
    assert_redirected_to courses_path
  end

  test "should redirect index when not logged in" do
    get courses_path
    assert_redirected_to root_url
  end

  test "index when student login" do
    log_in_as(@bacmive)
    get courses_path
    assert_template 'courses/index' 
  end
  
  test "index when teacher login" do
    log_in_as(@teacher)
    get courses_path
    assert_template 'courses/index' 
  end
  
end
