require 'thor'
require 'my_precious/version'
require 'my_precious/parser_2'

module MyPrecious
  class Error < StandardError; end
  # Your code goes here...
  class CLI < Thor

    desc 'bring_forth FILE', 'creates a .precious FILE where users can write their LOTR code'
    def bring_forth(file_name)
      file = File.open(file_name + '.precious', 'w')
      puts "You have succesfully brought forth #{file_name}.precious"
    end

    desc 'parse FILE', 'parse a .precious FILE and output the result'
    def parse reader_file_name, writer_file_name
      exts_are_valid = check_reader_and_writer_exts(reader_file_name, writer_file_name)
      if exts_are_valid
        file = File.open(reader_file_name, 'r')
        Parser2.parse_file file, writer_file_name
        puts "You have successfully transcribed #{reader_file_name}.precious into #{writer_file_name}"
        file.close
      end
    end

    # def speak_friend file_name
    #   isvalid = check_ext(file_name)
    #   if isvalid
    #     file = File.open file_name

    #     puts "You ran #{file_name}"
    #   end
    # end

    private

    def check_ext(file_name)
      accepted_writer_formats = '.rb'
      ext = File.extname(file_name)
      if accepted_writer_formats == ext
        return true
      else
        raise "#{file_name} is not a *Gollum  Cough* *Gollum Cough* ruby (file)!"
      end
    end

    def check_reader_and_writer_exts(reader_file, writer_file)
      isvalid = false;
      accepted_reader_formats = '.precious'
      accepted_writer_formats = '.rb'

      ext = File.extname(reader_file)
      if accepted_reader_formats == ext
        isvalid = true
      else
        raise "#{reader_file} is not a *Gollum  Cough* *Gollum Cough* precious (file)!"
      end
      check_ext(writer_file)
    end

  end #end of CLI
end
