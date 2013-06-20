require_relative 'student'

Student.drop
Student.create_table

student1 = Student.new
student1.name = "Desmond"
student1.save
