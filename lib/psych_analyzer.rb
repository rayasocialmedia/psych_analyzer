require "psych_analyzer/version"
require "memcache"
module PsychAnalyzer

  @cache = Memcache.new(:server => 'localhost:11211', :native => true, :segment_large_values => true) 
  @ignored_words = Array.new()
  @dictionary = Hash.new

  def self.train(trainingFiles)
    trainingData = {"dictionary"=>Array.new(), "ignored_words"=>Array.new()}
    unless !@cache.get('trainingData').nil?
      # initialize/read dictionary file
      dictionary_file = File.new(trainingFiles["dictionary"], 'r')
      dictionary_class = String.new("")
      dictionary_class_words = Array.new()
      # build dictionary array
      dictionary_file.each_line("\n") do |row|
        # set dictionary classes key
        unless !row.include?('#')
          dictionary_class = row.sub!('#', '').sub!("\n", '')
          @dictionary[dictionary_class] = Array.new
        end
        # assign class keywords of each dictionary class
        unless row=="\n"
          dictionary_class_words = Array.new()
          row.split(",").each do |word|
            dictionary_class_words.push(word.gsub("\"", '').strip) unless word == "\n"
          end
          @dictionary[dictionary_class].concat(dictionary_class_words)
        end
      end
      trainingData["dictionary"] = @dictionary
      # initialize/read ingored keywords file
      ignored_keywords_file = File.new(trainingFiles["ignored_keywords"], 'r')
      ignored_keywords_file.each_line("\n") do |row|
        row.split(",").each do |word|
          @ignored_words.push(word.gsub("\"", '').strip) unless word == "\n"
        end
      end
      trainingData["ignored_words"] = @ignored_words
      
      #cache the trained data 
      @cache.set('trainingData', trainingData, :expiry => (15*24*3600))
    else
      trainingData = @cache.get('trainingData')
      @dictionary = trainingData["dictionary"]
      @ignored_words = trainingData["ignored_words"]
    end
      #
    return true

    rescue => err
    puts "Exception: #{err}" 
    err
  end

  # Extract feature words from given string
  #
  # Example:
  #   >> input = ["sample statement", "sample statement2"]
  #   >> extract_feature_words(input)
  #
  # Arguments:
  #   contents: (Array of Strings)
  #
  # Returns:
  #   Hash of feature words in "word, repeat" pairs ex.
  #   { "sample" => 2, "statement" => 1, "statement2" => 1 }
  def self.extract_feature_words(contents)
    words = Hash.new(0) 
    contents.each do |content| 
      tokens = content.split(/[^a-zA-z]/)
      tokens.each do |token|
        token.downcase! unless token.upcase == token # make token all lowercase unless it is all caps
        words[token] += 1 unless token.empty? || @ignored_words.include?(token.downcase)
      end
    end

    words.keys.sort

    return words

    rescue => err
    puts "Exception: #{err}" 
    err
  end
  
  def self.analyze(contents)
    psychological_profile = Hash.new(0)
    _classes_total = 0

    (self.extract_feature_words(contents)).each do |word, repeated|
      @dictionary.each do |_class, _class_words|
        psychological_profile[_class] += 1 unless !_class_words.include?(word)  
      end
    end
    
    psychological_profile.each { |profile_class, total| _classes_total += total  } 
    psychological_profile.each { |profile_class, total| psychological_profile[profile_class] = (total.to_f/_classes_total.to_f*100.0).round(2) }
    
    return psychological_profile

    rescue => err
    puts "Exception: #{err}" 
    err
  end
end
