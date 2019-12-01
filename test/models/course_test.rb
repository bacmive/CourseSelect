require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:cheech)
    @course =Course.new(name: "1", course_type: "2", course_time: "3",course_week: "4",
            class_room: "5", credit: "6", teaching_type: "7", exam_type: "8", teacher_id: @user.id)
  end

  test "should be valid" do
    assert @course.valid?
  end
end
