class EdxCli::Cli

  BASE_URL = "https://www.futurelearn.com/"
  EDX_PROGRAMS_URL = "https://www.futurelearn.com/programs"

  def run #Program start
    system "clear"
    get_programs
    display_programs
    select_action
  end

  def get_programs
    programs = EdxCli::Scraper.scrape_programs(EDX_PROGRAMS_URL)
    EdxCli::Program.create_from_collection(programs)
  end

  def get_courses(prog_num)
    EdxCli::Program.all[prog_num-1].courses ||= EdxCli::Course.create_from_collection(EdxCli::Scraper.scrape_courses(BASE_URL + EdxCli::Program.all[prog_num-1].url))
  end

  def display_programs
    puts "Unfortunately, it seems that there are no upcoming programs on EdX." if EdxCli::Program.all.count == 0
    EdxCli::Program.all.each.with_index do |program, i|
      if i < 9
        puts "#{i+1}.  Title: #{program.title}"
      else
        puts "#{i+1}. Title: #{program.title}"
      end
      puts "    School: #{program.school}"
      puts "    Courses: #{program.num_of_courses}"
      puts "    Duration: #{program.duration}"
      puts
    end
  end

  def display_courses(courses)
    system "clear"
    puts "Apparently there are no courses for this program or an error occured." if courses.count == 0
    courses.each.with_index do |course, i|
      if i < 9
        puts "#{i+1}.  Title: #{course.title}"
      else
        puts "#{i+1}. Title: #{course.title}"
      end
      if course.duration && course.effort
        puts "    School: #{course.school}"
        puts "    Duration: #{course.duration}"
        puts "    Effort: #{course.effort}"
      end
      puts "    Description: #{course.description}"
      puts
    end
  end

  def select_action
    message = "Type program number for details, 'list' to relist programs or 'exit' to leave"
    loop do
      puts message
      input = gets.strip
      case input
      when "list"
        display_programs
        message = "Type program number for details, 'list' to relist programs or 'exit' to leave"
      when "exit"
        break
      else
        if message == "Type program number for details, 'list' to relist programs or 'exit' to leave" && (1..EdxCli::Program.all.count).include?(input.to_i)
          courses = get_courses(input.to_i)
          display_courses(courses)
          message = "Type 'list' to relist programs or exit to leave the program"
        end
      end
    end
  end

end
