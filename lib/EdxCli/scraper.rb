class EdxCli::Scraper

  def self.scrape_programs(url)
    puts "Please wait while retrieving info from EdX. This will take some time."
    browser = Watir::Browser.start(url, :firefox, headless: true)
    doc = Nokogiri::HTML(browser.html)
    browser.close
    program_list = doc.css(".course-card")
    program_list.collect do |program|
      {title: program.css(".title-heading").text.strip,
       school: program.css(".label").text.strip,
       description: program.css(".ellipsis-overflowing-child").text.strip,
       availability: program.css(".availability").text.strip,
       url: program.css("a").attribute("href").value}
     end
   end

  def self.scrape_courses(url)
    puts "Please wait while retrieving courses. This will take some time."
    browser = Watir::Browser.start(url, :firefox, headless: true)
    doc = Nokogiri::HTML(browser.html)
    browser.close
    course_list = doc.css(".enroll-card")
    course_list.collect do |course|
      {title: course.css(".course-title").text.strip,
       description: course.css(".subtitle").text.strip,
       start: course.css(".course-start").first.text.strip,
       url: course.css("a").attribute("href").value}
     end
  end

end
