def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  @students = []
  # get the first name
  puts "name:"
  name = gets.chomp
  puts "cohort:"
  cohort = gets.chomp
  cohort = "November" if cohort.empty?
  # while the name is not empty, repeat this code

    until name == "" do
      # add the student hash to the array
      if (name.start_with? "a", "b", "g", "f") && (name.length < 12)
        then add_to_student_list(name,cohort)
            puts "Now we have #{@students.count} students"
      end 
    # get another name from the user
        puts "name:"
        name = gets.chomp
        puts "cohort:"
        cohort = gets.chomp
        cohort = "November" if cohort.empty?
    end
  
  # return the array of students
  @students
end

def print_header
  puts "The students of Villains Academy".center(18)
  puts "-------------".center(18)
end

def print(students)
  @students.each_with_index do |student, id|
      puts "       #{id+1}. #{student[:name]} (#{student[:cohort]} cohort)".ljust(40)
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def add_to_student_list(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    add_to_student_list(name,cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exist?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def print_footer(students)
  puts "Overall, we have #{@students.count} great students".center(18)
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load students.csv"
  puts "9. Exit" 
end

def show_students
  print_header
  print(@students)
  print_footer(@students)
end

def interactive_menu 
  @students = []
  loop do
    print_menu

    selection = gets.chomp

    case selection
    when "1"
      @students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
#nothing happens until we call the methods
