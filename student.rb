require "sqlite3"


class Student

  attr_accessor :name, :id

  ATTRIBUTES = []

  DB = SQLite3::Database.new("students.db")

  def self.db
    DB
  end

  def initialize

  end

  def self.table_exists?()
    table = ("SELECT name FROM sqlite_master
    WHERE type= 'table' AND name= 'students';")
    table != []
  end

  def self.drop
    if self.table_exists?
      Student.db.execute( "DROP TABLE students" )
    else
      return true
    end
  end


  def self.create_table
    Student.db.execute <<-SQL 
      CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
      );
      SQL
  end

  def save
    # id = self.id
    # name = name.id
    Student.db.execute("INSERT INTO students (name) VALUES (?)", [@name])
    self.id = self.retrieve_id
  end

  def retrieve_id
    name = self.name
    self.id = Student.find_by_name(name).id
  end

  def self.rebuild(student_array)
    student = Student.new
    student.id = student_array[0]
    student.name = student_array[1]
    return student
  end

  def self.find_by_name(student_name)
    student_array = Student.db.execute("SELECT * FROM students WHERE name = '#{student_name}'").flatten
    rebuild(student_array)
  end

  def self.all
    class_array = Student.db.execute("SELECT * FROM students")
    class_array.collect{|student| rebuild(student) }
  end

  def self.find(student_id)
    student_array = Student.db.execute("SELECT * FROM students WHERE id = '#{student_id}'").flatten
    rebuild(student_array)
  end

end

Student.drop
Student.create_table

a = Student.new
a.name = ("Desmond")
a.save

b = Student.new
b.name = ("Jen")
b.save








# class Student
  
#   student.find.1 shoudl return an object that is an instance of the student class
#   so the find method is going to have to pull up data from the database and then instantiate a student object with all that data
#   in order to return it


#   def student.new_from_database


#   # put sql clauses in little methods

#   def self.create_table



#   def self.create_table_sql



#   def self.table_name


#   fed self.columns_for_sql


#   fed self.all
#   db.execute("SELECT * FROM students")

