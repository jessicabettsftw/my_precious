require 'thor'
require 'my_precious/version'
require 'my_precious/parser'

module MyPrecious
  class Error < StandardError; end
  # Your code goes here...
  class CLI < Thor

    desc 'forge file_name', 'creates a .precious file where users can write their LOTR code'
    def forge(file_name)
      file = File.open(file_name + '.precious', 'w')
      puts "#{file_name}.precious, one file to rule them all"
    end

    desc 'bring_forth read file and writer file', 'parse a .precious read file and outputs the result to the writer file'
    def bring_forth(reader_file_name, writer_file_name)
      exts_are_valid = check_reader_and_writer_exts(reader_file_name, writer_file_name)
      if exts_are_valid
        file = File.open(reader_file_name, 'r')
        Parser.parse_file file, writer_file_name
        puts "#{reader_file_name} has been brought forth. It has been transcribed into #{writer_file_name}"
        file.close
      end
    end

    desc 'destroy file name', 'if a .precious file already exists, it will be destroyed'
    def destroy(file_name)
      if File.exist?(file_name)
        File.delete(file_name)
        puts "It's done... It's over now. #{file_name} has been destroyed"
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
