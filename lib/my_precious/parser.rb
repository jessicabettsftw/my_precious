class Parser
  WRITER_FILE = 'output.rb'
  # KEYWORDS
  #LINE_KEYWORDS = [',', '.', '?', '!', ';']
  PUT_KEYWORDS = ['bring forth the ring', 'says', 'screams', 'exclaims', 'sobbs', 'coughs']
  COMMENT_KEYWORDS = ['second breakfast', 'wear the ring']
  ASSIGNMENT_KEYWORDS = ['is', 'are', 'was', 'has']
  INCREMENT_KEYWORDS = ['eats lembas bread', 'fortifies stronghold', 'rests', 'recieves Evenstar', 'reforges Narsil']
  DECREMENT_KEYWORDS = ['runs out of lembas bread', 'lost', 'hunted by orcs']
  ADDITION_KEYWORDS = ['joins', 'join', 'and', 'accompanies']
  SUBTRACTION_KEYWORDS = ['leaves the fellowship', 'stabs', 'banishes', 'steals']
  MULTIPLICATION_KEYWORDS = ['gives aid to', 'procreates', 'bolsters']
  DIVISION_KEYWORDS = ['decapitates', 'dismembers']
  COMPARISON_KEYWORDS = ['equal', 'same', 'similar']
  CONDITION_KEYWORDS = ['does', 'if', 'will']
  END_KEYWORDS = ['you shall not pass']
  TRUE_KEYWORDS = ['precious']
  LOOP_KEYWORDS = ['whilst', 'during the journey']
  GREATER_THAN_KEYWORDS = ['stronger than', 'more']
  LESS_THAN_KEYWORDS = ['weaker than', 'less']
  FUNCTION_DEF_KEYWORDS = ['transcribe', 'tell a story']
  FUNCTION_CALL_KEYWORDS = ["theyre taking the hobbits to"]
  PARAM_KEYWORDS = ['with']
  NEGATION_KEYWORDS = ['not']
  CLASS_KEYWORDS = ['chapter']
  OPERATOR_KEYWORDS = ['#', '+', '-', '=', '*', '/', '+=1', '-=1', 'puts', '==', 'if', 'end', 'true', 'while', '>', '<', '!', 'def', '(', ')', 'class']

  ALICIA_KEYS = [END_KEYWORDS, PUT_KEYWORDS, ASSIGNMENT_KEYWORDS, INCREMENT_KEYWORDS, DECREMENT_KEYWORDS, ADDITION_KEYWORDS, SUBTRACTION_KEYWORDS, DIVISION_KEYWORDS, MULTIPLICATION_KEYWORDS, COMPARISON_KEYWORDS, CONDITION_KEYWORDS, TRUE_KEYWORDS, LOOP_KEYWORDS, GREATER_THAN_KEYWORDS, LESS_THAN_KEYWORDS, NEGATION_KEYWORDS, FUNCTION_DEF_KEYWORDS, FUNCTION_CALL_KEYWORDS, CLASS_KEYWORDS]

  MAP = [{'puts': PUT_KEYWORDS}, {'#': COMMENT_KEYWORDS}, {'=': ASSIGNMENT_KEYWORDS}, {'+=1': INCREMENT_KEYWORDS}, {'-=1': DECREMENT_KEYWORDS}, {'+': ADDITION_KEYWORDS}, {'-': SUBTRACTION_KEYWORDS}, {'*': MULTIPLICATION_KEYWORDS}, {'/': DIVISION_KEYWORDS}, {'==': COMPARISON_KEYWORDS}, {'if': CONDITION_KEYWORDS}, {'end': END_KEYWORDS}, {'true': TRUE_KEYWORDS}, {'while': LOOP_KEYWORDS}, {'>': GREATER_THAN_KEYWORDS}, {'<': LESS_THAN_KEYWORDS}, {'!': NEGATION_KEYWORDS}, {'def': FUNCTION_DEF_KEYWORDS}, {'': FUNCTION_CALL_KEYWORDS},{'(': PARAM_KEYWORDS}, {'class': CLASS_KEYWORDS}]

  def self.parse_file(file, output_file_name)
    str = ""
    writer_file_name = output_file_name
    file.each_with_index do |file, index|
      file.each_line do |line|
        line = parse_line(line, index)
        str << (line + "\n")
      end
    end
    write(str, writer_file_name)
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
      quote = get_quote(line)
      line = line.gsub(quote, 'quote_placeholder')
    end

    #check if line is a comment
    comment = ""
    if COMMENT_KEYWORDS.any? { |word| line.include?(word) }
      line = parse(line, COMMENT_KEYWORDS)
      comment = store_important(line, '#')
      line = line.gsub(comment, 'comment_placeholder')
    end

    #check if line has params
    params = ""
    if ((PARAM_KEYWORDS.any? { |word| line.include?(word) }) &&
      ((FUNCTION_DEF_KEYWORDS.any? { |word| line.include?(word) }) ||
      (FUNCTION_CALL_KEYWORDS.any? { |word| line.include?(word) })))
      line = parse(line, PARAM_KEYWORDS)
      params = remove_newline(store_important(line, '('))
      line = line.gsub(params, 'param_placeholder ')  + ')'
    end

    class_word = ""
    if CLASS_KEYWORDS.any? { |word| line.include?(word) }
      line = parse(line, CLASS_KEYWORDS)
      class_word = store_important(line, ':')
      line = line.gsub(class_word, ' class_word_placeholder')
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

    if line.include? ('param_placeholder')
      line = line.gsub('param_placeholder', params.downcase)
      line = format_function(line)
    end

    if line.include? ('class_word_placeholder')
      line = line.gsub('class_word_placeholder', "#{class_word}")
    end

    # write("#{line}")
    return line
    end
  end

  def self.check_for_keywords(line)
    ALICIA_KEYS.each do |keywords|
      line = parse(line, keywords)
    end
    line
  end

  # METHODS
  def self.parse(line, keywords)
    keywords.each do |keyword|
      if line.include? keyword
        puts keyword
        replacement = find_replacement(keywords)
        line = line.gsub(keyword, replacement)
      end
    end
    return line
  end

  def self.purify(word)
    word = word.gsub(/[!@%&.?,]/,'')# get rid of special chars
  end

  def self.remove_newline(line)
    line.gsub(/\n/, "")
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
    elsif word == '"quote_placeholder"' #if string/quote
      valuable = true
    elsif word == '#comment_placeholder' #if comment
      valuable = true
    elsif word == '(param_placeholder' #if params
      valuable = true
    elsif word == 'class_word_placeholder' #if class
      valuable = true
    elsif word.to_i.to_s == word #if num
      valuable = true
    elsif OPERATOR_KEYWORDS.include? word #if operator
      valuable = true
    end
    valuable
  end

  def self.get_quote(phrase)
    phrase_array = phrase.split('')
    index = phrase_array.find_index { |i| i == '"'} + 1
    quote = ""
    while phrase_array[index] != '"'
      quote << phrase_array[index]
      index += 1
    end
    quote
  end

  def self.store_important(phrase, key)
    phrase_array = phrase.split('')
    index = phrase_array.find_index { |i| i == key} + 1
    string = ""
    while index < phrase_array.length
      string << phrase_array[index]
      index += 1
    end
    string
  end

  def self.find_replacement(keywords)
    MAP.each do |hash|
      hash.each do |key, value|
        if value == keywords
          return key.to_s
        end
      end
    end
    return nil
  end

  def self.format_function(line)
    phrase_array = line.split('')
    index = phrase_array.find_index { |i| i == "("}
    phrase_array.delete_at(index - 1)
    phrase_array.delete_at(index - 2)
    phrase_array.join("")
  end

  def self.write(str, writer_file_name)
    writer_file = File.open(writer_file_name, 'w')
    writer_file.write(str)
  end
  
end #end of Parser Class