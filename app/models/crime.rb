class Crime < ActiveRecord::Base
  attr_protected

  def self.unique_column_values column_name
    self.select("DISTINCT \"#{column_name}\"")
        .map(&:"#{column_name}")
        .reject(&:nil?)
  end

  def self.value_per_column_type column_type, column_value, value
    self.select("#{value}")
        .where("#{column_type} = ?", column_value)
        .map(&:"#{value}")
        .reject(&:nil?)
  end

  def self.stopwords
    ["a", "able", "about", "across", "after", "all", "almost", "also", "am", "among", "an", "and", "any", "are", "as", "at", "be", "because", "been", "but", "by", "can", "cannot", "could", "dear", "did", "do", "does", "either", "else", "ever", "every", "for", "from", "get", "got", "had", "has", "have", "he", "her", "hers", "him", "his", "how", "however", "i", "if", "in", "into", "is", "it", "its", "just", "least", "let", "like", "likely", "may", "me", "might", "most", "must", "my", "neither", "no", "nor", "not", "of", "off", "often", "on", "only", "or", "other", "our", "own", "rather", "said", "say", "says", "she", "should", "since", "so", "some", "than", "that", "the", "their", "them", "then", "there", "these", "they", "this", "tis", "to", "too", "twas", "us", "wants", "was", "we", "were", "what", "when", "where", "which", "while", "who", "whom", "why", "will", "with", "would", "yet", "you", "your", 'victim', 'come', 'floor', 'failed', 'suspect', 'front', 'put', 'call', 'going', 'give', 'see', 'help', 'don', 'OUT?', 'unk.', 'narr', 'narrative', 'narrative.', 'unknown', 'n/a', 'report', 'back', 'refer']
  end
end
