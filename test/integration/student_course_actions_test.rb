require 'test_helper'
class StudentCourseActionsTest < ActionDispatch::IntegrationTest
  def setup
    @yuwen = courses(:yuwen)
    @shuxue= courses(:shuxue)
    @teacher=users(:archer)
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
    assert_template 'courses/new'
    #assert_redirected_to root_url
  end


end
