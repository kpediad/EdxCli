class EdxCli::Cli

  EDX_PROGRAMS_URL = "https://www.edx.org/course/?program=all&availability=starting_soon"
  WORD_COUNT = 6

  def run #Program start
    puts "Welcome to the EdX starting soon programs!"
    puts "Please wait while retrieving info from EdX. This will take some time."
    get_programs
    display_programs
    select_action
  end

  def get_programs
    programs = EdxCli::Scraper.scrape_programs(EDX_PROGRAMS_URL)
    EdxCli::Program.create_from_collection(programs)
  end

  def get_courses(prog_num)
    EdxCli::Program.all[prog_num-1].courses ||= EdxCli::Course.create_from_collection(EdxCli::Scraper.scrape_courses(EdxCli::Program.all[prog_num-1].url))
  end

  def display_programs
    system "clear"
    puts "Unfortunately, it seems that there are no upcoming programs on EdX." if EdxCli::Program.all.count == 0
    EdxCli::Program.all.each.with_index do |program, i|
      if i < 9
        puts "#{i+1}.  Title: #{program.title}"
      else
        puts "#{i+1}. Title: #{program.title}"
      end
      puts "    #{program.school}"
      puts "    #{program.availability}"
      program.description.split(" ").each_slice(WORD_COUNT).with_index do |slice, i|
        part = slice.to_a.join(" ")
        if i == 0
          puts "    Description: #{part}"
        else
          puts "                 #{part}"
        end
      end
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
        course.description.split(" ").each_slice(WORD_COUNT).with_index do |slice, i|
          part = slice.to_a.join(" ")
          if i == 0
            puts "    Description: #{part}"
          else
            puts "                 #{part}"
          end
        end
        puts "    #{course.start}"
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
