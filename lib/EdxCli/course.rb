class EdxCli::Course

  attr_accessor :title, :description, :start, :url

  def initialize(course_hash)
    course_hash.each{|attr_name, attr_value| self.send(attr_name.to_s + "=", attr_value)}
  end

  def self.create_from_collection(courses)
    courses.collect{|course_hash| EdxCli::Course.new(course_hash)}
  end
  
end
