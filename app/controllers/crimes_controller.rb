class CrimesController < ApplicationController
  def show
    @neighborhood_fucks_given = most_common_neighborhoods_per_word 'fuck'
    @neighborhood_bitch = most_common_neighborhoods_per_word 'bitch'
    @neighborhood_kill = most_common_neighborhoods_per_word 'kill'
    #@common_word_by_neighborhood = most_unusual_action_by_column 'neighborhood'
    #@common_word_by_lighting = most_unusual_action_by_column 'lighting'
    #@common_word_by_dow = most_unusual_action_by_column 'day_week'
    #@crimes_by_dow = number_of_crimes_by_column 'day_week', 7
    #@crimes_by_neighborhood = number_of_crimes_by_column 'neighborhood', 10
    #@crimes_by_weather = number_of_crimes_by_column 'weather', 10
    #@crimes_by_lighting = number_of_crimes_by_column 'lighting', 10
  end

  private

  def most_common_neighborhoods_per_word word
    all_unusual_actions_by_neighborhood =
      all_unusual_actions_by_column 'neighborhood'

    word_occurrence_per_neighborhood = {}

    all_unusual_actions_by_neighborhood.each do |neighborhood, unusual_action_words|
      word_occurrence_per_neighborhood[neighborhood] = 0

      unusual_action_words.each do |unusual_action_word|
        if unusual_action_word.downcase == word.downcase
          word_occurrence_per_neighborhood[neighborhood] =
            word_occurrence_per_neighborhood[neighborhood] + 1
        end
      end
    end

    word_occurrence_per_neighborhood.sort_by { |v, k| k }.reverse!.first(15)
  end

  def most_unusual_action_by_column column_name
    most_unusual_actions = all_unusual_actions_by_column column_name

    most_unusual_actions.each do |unique_column_value, unusual_actions|
      most_unusual_actions[unique_column_value] =
        most_common_word_in_array(unusual_actions)
    end
  end

  def all_unusual_actions_by_column column_name
    words_per_unique_column_value = {}

    Crime.unique_column_values(column_name).each do |unique_column_value|
      words_per_unique_column_value[unique_column_value] = []

      Crime.value_per_column_type(
        column_name,
        unique_column_value,
        'unusualactions'
      ).each do |sentence|
        sentence.split(' ').each do |word|
          if filter_filler_word word
            words_per_unique_column_value[unique_column_value].push word
          end
        end
      end
    end

    words_per_unique_column_value
  end

  def most_common_word_in_array array
    freq = array.inject(Hash.new(0)) { |k, v| k[v] += 1; k }
    array.max_by { |v| freq[v] }
  end

  def number_of_crimes_by_column column_name, result_count
    crimes_per_column_type = {}

    Crime.unique_column_values(column_name).each do |unique_column_type|
      crime_count = Crime.where("#{column_name} = ?", unique_column_type).count
      crimes_per_column_type[unique_column_type] = crime_count
    end

    crimes_per_column_type.sort_by { |v, k| k }.reverse!.first(result_count)
  end

  def filter_filler_word word
    !Crime.stopwords.include? word.downcase
  end
end
