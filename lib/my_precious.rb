require 'thor'
require "my_precious/version"

module MyPrecious
  class Error < StandardError; end
  # Your code goes here...
  class CLI < Thor

    desc 'bring_forth FILE', 'creates a .precious FILE where users can write their LOTR code'
    def bring_forth(filename)
      file = File.open(filename + '.precious', 'w')
      puts "You have succesfully brought forth tome.rb"
    end

    desc 'parse FILE', 'parse a .precious FILE and output the result'
    def parse input_file_name, output_file_name
      file = File.open input_file_name
      Parser.parse_file file, output_file_name
      puts "You have successfully transcribed tome.rb"
      file.close
    end

    # def run filename
    #   file = File.open filename  
    #   puts "You have successfully closed tome.rb"
    # end

    # def speak_friend
    # end

  end #end of CLI
end
