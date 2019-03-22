require 'pry'

class Parser
  WRITER_FILE = 'output.rb'
  # KEYWORDS
  PUT_KEYWORDS = ['bring forth the ring', 'says', 'screams', 'exclaims', 'sobbs', 'coughs']
  COMMENT_KEYWORDS = ['second breakfast', 'wear the ring']
  ASSIGNMENT_KEYWORDS = ['is', 'has', 'was']
  INCREMENT_KEYWORDS = ['eats lembas bread', 'fortifies stronghold', 'rests', 'recieves Evenstar', 'reforges Narsil']
  DECREMENT_KEYWORDS = ['runs out of lembas bread', 'lost', 'hunted by orcs']
  ADDITION_KEYWORDS = ['joins', 'join', 'and', 'accompanies']
  SUBTRACTION_KEYWORDS = ['leaves the fellowship', 'stabs', 'banishes', 'steals']
  MULTIPLICATION_KEYWORDS = ['gives aid to', 'procreates', 'bolsters']
  DIVISION_KEYWORDS = ['decapitates', 'dismembers']
  COMPARISON_KEYWORDS = ['as', 'equal']
  CONDITION_KEYWORDS = ['does', 'if', 'will']
  END_KEYWORDS = ['you shall not pass']
  TRUE_KEYWORDS = ['precious']
  FALSE_KEYWORDS = ['not precious']
  LOOP_KEYWORDS = ['whilst', 'during the journey']
  GREATER_THAN_KEYWORDS = ['stronger than', 'more']
  LESS_THAN_KEYWORDS = ['weaker than', 'less']
  OPERATOR_KEYWORDS = ['#', '+', '-', '=', '*', '/', '+=1', '-=1', 'puts', '==', 'if', 'end', 'true', 'false', 'while', '>', '<']


  ALICIA_KEYS = [PUT_KEYWORDS, COMMENT_KEYWORDS, ASSIGNMENT_KEYWORDS,
     INCREMENT_KEYWORDS, DECREMENT_KEYWORDS, ADDITION_KEYWORDS,
  SUBTRACTION_KEYWORDS, DIVISION_KEYWORDS, MULTIPLICATION_KEYWORDS,
  COMPARISON_KEYWORDS, CONDITION_KEYWORDS, END_KEYWORDS, TRUE_KEYWORDS, FALSE_KEYWORDS, LOOP_KEYWORDS, GREATER_THAN_KEYWORDS, LESS_THAN_KEYWORDS]

  MAP = [{'puts': PUT_KEYWORDS}, {'#': COMMENT_KEYWORDS},
    {'=': ASSIGNMENT_KEYWORDS}, {'+=1': INCREMENT_KEYWORDS},
    {'-=1': DECREMENT_KEYWORDS}, {'+': ADDITION_KEYWORDS},
    {'-': SUBTRACTION_KEYWORDS}, {'*': MULTIPLICATION_KEYWORDS},
   {'/': DIVISION_KEYWORDS}, {'==': COMPARISON_KEYWORDS},
   {'if': CONDITION_KEYWORDS}, {'end': END_KEYWORDS}, {'true': TRUE_KEYWORDS}, {'false': FALSE_KEYWORDS}, {'while': LOOP_KEYWORDS}, {'>': GREATER_THAN_KEYWORDS}, {'<': LESS_THAN_KEYWORDS}]

  def self.parse_file(file)
    str = ""
    file.each_with_index do |file, index|
      file.each_line do |line|
        line = parse_line(line, index)
        str << (line + "\n")
      end
    end
    write(str)
  end

  def self.parse_line(line, index)

    #error handeling
    #ignore lines of length 1, its empty
    if line.length == 1
      # write("#{line}")
      return line
    else

      #check if there are strings in line
      quote = ""
      if line.include? '"'
        quote = get_string(line)
        line = line.gsub(quote, 'quote_placeholder')
      end

      #check if line is a comment
      comment = ""
      if COMMENT_KEYWORDS.any? { |word| line.include?(word) }
        line = parse(line, COMMENT_KEYWORDS)
        comment = get_comment(line)
        line = line.gsub(comment, 'comment_placeholder')
      end

      #get rid of special chars
      line_array = line.split(" ")
      line_array.each_with_index do |word, index|
        line_array[index] = purify(word)
      end

      #check for keywords
      #calls if statements
      line = line_array.join(" ")
      line = check_for_keywords(line)

      #remove extra english words
      line = only_valuable_words(line).downcase

      #put string back into line
      if line.include? ('"quote_placeholder"')
        line = line.gsub('quote_placeholder', quote)
      end

      if line.include? ('comment_placeholder')
        line = line.gsub('comment_placeholder', comment)
      end
      #puts "end line: #{line}"
      # write("#{line}")
      return line
    end
  end

  def self.check_for_keywords(line)
    ALICIA_KEYS.each do |keywords|
      if keywords.any? { |word| line.include?(word) }
        line = parse(line, keywords)
      end
    end
    line
  end

  # METHODS
  def self.parse(line, keywords)
    keywords.each do |keyword|
      if line.include? keyword
        replacement = find_replacement(keywords)
        line = line.gsub(keyword, replacement)
      end
    end
    return line
  end

  def self.write(str)
    if File.exist?(WRITER_FILE)
      writer_file = File.open(WRITER_FILE, 'a')
    else
      writer_file = File.open(WRITER_FILE, 'w')
    end
    writer_file.write(str + "\n")
  end

  def self.purify(word)
    word = word.gsub(/[!@%&.?,]/,'') # get rid of special chars
  end

  def self.only_valuable_words(line)
    important_words = []
    line_array = line.split(" ")
    line_array.each do |word|
      valuable_word = valuable?(word)
      if valuable_word
        important_words << word
      end
    end
    line = important_words.join(" ")
  end

  def self.valuable?(word)
    valuable = false
    if /[[:upper:]]/.match(word[0]) #if variable
      valuable = true
    elsif word == '"quote_placeholder"' #if string
      valuable = true
    elsif word == '#comment_placeholder' #if string
      valuable = true
    elsif word.to_i.to_s == word #if num
      valuable = true
    elsif OPERATOR_KEYWORDS.include? word #if operator
      valuable = true
    end
    valuable
  end

  def self.get_string(phrase)
    phrase_array = phrase.split('')
    index = phrase_array.find_index { |i| i == '"'} + 1
    quote = ""
    while phrase_array[index] != '"'
      quote << phrase_array[index]
      index += 1
    end
    quote
  end

  def self.get_comment(phrase)
    phrase_array = phrase.split('')
    index = phrase_array.find_index { |i| i == '#'} + 1
    comment = ""
    while index < phrase_array.length
      comment << phrase_array[index]
      index += 1
    end
    comment
  end

  def self.find_replacement(keywords)
    MAP.each do |hash|
      hash.each do |key, value|
        if value == keywords
          return key.to_s
        end
      end
    end
  end


end
