class Enrollment < ApplicationRecord
    
  belongs_to :student,
    class_name: "User",
    primary_key: :id,
    foreign_key: :student_id
  


end
