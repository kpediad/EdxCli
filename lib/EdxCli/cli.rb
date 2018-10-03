class EdxCli::Cli

  EDX_PROGRAMS_URL = "https://www.edx.org/course/?program=all&availability=starting_soon"
  WORD_COUNT = 6

  def run #Program start
    puts "Welcome to the EdX starting soon programs!"
    display(get_programs)
    select_action
  end

  def get_programs
    EdxCli::Program.all ||= EdxCli::Program.create_from_collection(EdxCli::Scraper.scrape_programs(EDX_PROGRAMS_URL))
  end

  def get_courses(prog_num)
    EdxCli::Program.all[prog_num-1].courses ||= EdxCli::Course.create_from_collection(EdxCli::Scraper.scrape_courses(EdxCli::Program.all[prog_num-1].url))
  end

  def display(items)
    system "clear"
    puts "No programs / courses to display!" if items.count == 0
    items.each.with_index do |item, i|
      if i < 9
        puts "#{i+1}.  Title: #{item.title}"
      else
        puts "#{i+1}. Title: #{item.title}"
      end
      item.description.split(" ").each_slice(WORD_COUNT).with_index do |slice, i|
        part = slice.to_a.join(" ")
        if i == 0
          puts "    Description: #{part}"
        else
          puts "                 #{part}"
        end
      end
      if item.is_a?(EdxCli::Program)
        puts "    #{item.school}"
        puts "    #{item.availability}"
      else
        puts "    #{item.start}"
      end
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
        display(get_programs)
        message = "Type program number for details, 'list' to relist programs or 'exit' to leave"
      when "exit"
        break
      else
        if message == "Type program number for details, 'list' to relist programs or 'exit' to leave" && (1..EdxCli::Program.all.count).include?(input.to_i)
          display(get_courses(input.to_i))
          message = "Type 'list' to relist programs or exit to leave the program"
        end
      end
    end
  end

end
