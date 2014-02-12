class CrimesController < ApplicationController
  def show
    @common_word_by_neighborhood = most_common_word_by_column 'neighborhood'
    @common_word_by_lighting = most_common_word_by_column 'lighting'
    @common_word_by_dow = most_common_word_by_column 'day_week'
    @crimes_by_dow = number_of_crimes_by_column 'day_week', 7
    @crimes_by_neighborhood = number_of_crimes_by_column 'neighborhood', 10
    @crimes_by_weather = number_of_crimes_by_column 'weather', 10
    @crimes_by_lighting = number_of_crimes_by_column 'lighting', 10
  end

  private

  def most_common_word_by_column column_name
    words_per_unique_column_type = {}

    Crime.unique_column_types(column_name).each do |unique_column_type|
      words_per_unique_column_type[unique_column_type] = []

      Crime.value_per_column_type(
        column_name,
        unique_column_type,
        'unusualactions'
      ).each do |sentence|
        sentence.split(' ').each do |word|
          if filter_filler_word word
            words_per_unique_column_type[unique_column_type].push word
          end
        end
      end
    end

    words_per_unique_column_type.each do |unique_column_type|
      words_per_unique_column_type[unique_column_type[0]] =
        most_common_word_in_array(unique_column_type[1])
    end
  end

  def most_common_word_in_array array
    freq = array.inject(Hash.new(0)) { |k, v| k[v] += 1; k }
    array.max_by { |v| freq[v] }
  end

  def number_of_crimes_by_column column_name, result_count
    crimes_per_column_type = {}

    Crime.unique_column_types(column_name).each do |unique_column_type|
      crime_count = Crime.where("#{column_name} = ?", unique_column_type).count
      crimes_per_column_type[unique_column_type] = crime_count
    end

    crimes_per_column_type.sort_by { |v, k| k }.reverse!.first(result_count)
  end

  def filter_filler_word word
    bad_words = [
      'you',
      'i',
      'see',
      'victim',
      'suspect',
      'refer',
      'to',
      'the',
      'can',
      'unknown',
      'he',
      'she',
      'entered',
      'went',
      'let',
      'got',
      'there',
      'motioned',
      'and',
      'removed',
      'trying',
      'mv',
      'my',
      'want',
      'of',
      'put',
      'im',
      'oh',
      'give',
      'in',
      'do'
    ]
    !bad_words.include? word.downcase
  end
end
