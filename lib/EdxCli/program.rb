class EdxCli::Program

  @@all = nil

  attr_accessor :title, :description, :school, :availability, :url, :courses

  def initialize(prog_hash)
    prog_hash.each{|attr_name, attr_value| self.send(attr_name.to_s + "=", attr_value)}
  end

  def self.create_from_collection(programs)
    programs.collect{|prog_hash| EdxCli::Program.new(prog_hash)}
  end

  def self.all
    @@all
  end

  def self.all=(programs)
    @@all = programs
  end

end
