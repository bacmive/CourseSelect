# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#-------------------------------------------------------------------------------------

teacher_map={
    35 => {name: "谭四君", department: "计算机与控制学院"}
}

course_map={
    
    35 => {course_code: "66666666H", name: "上天入地", course_type: "公共选修课", credit: "40/1.0", limit_num: 1, course_week: "第4-14周	", course_time: "周二(7-8)", class_room: "天宫", teaching_type: "课外讲授为主", exam_type: "课堂开卷", open: true},
}

teacher_map.keys.each do |index|
  teacher=User.create!(
      name: teacher_map[index][:name],
      email: "teacher#{index}@test.com",
      department: teacher_map[index][:department],
      password: "password",
      password_confirmation: "password",
      teacher: true
  )

  teacher.teaching_courses.create!(
      course_code: course_map[index][:course_code],
      name: course_map[index][:name],
      course_type: course_map[index][:course_type],
      credit: course_map[index][:credit],
      limit_num: course_map[index][:limit_num],
      course_week: course_map[index][:course_week],
      course_time: course_map[index][:course_time],
      class_room: course_map[index][:class_room],
      teaching_type: course_map[index][:teaching_type],
      exam_type: course_map[index][:exam_type],
      open: course_map[index][:open],
  )

end

















