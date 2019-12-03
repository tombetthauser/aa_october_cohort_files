class Enrollment < ApplicationRecord
    
  has_many :student,
    class_name: "User",
    primary_key: :id,
    foreign_key: :student_id
        
  has_many :course,
    class_name: "User",
    primary_key: :id,
    foreign_key: :course_id

end
