class CrimesController < ApplicationController
  def show
    @dow = number_of_crimes_by_dow

    @all_words = most_common_word_by_neighborhood

    @crimes_by_neighborhood = number_of_crimes_by_column 'neighborhood', 10
    @crimes_by_weather = number_of_crimes_by_column 'weather', 10
    @crimes_by_lighting = number_of_crimes_by_column 'lighting', 10
  end

  private

  def most_common_word_by_neighborhood
    words = {}

    Crime.select('DISTINCT "neighborhood"')
      .map(&:neighborhood)
      .reject(&:nil?)
      .each do |neighborhood|

      words[neighborhood] = []

      unusualactions = Crime.select(:unusualactions)
        .where("neighborhood = ?", neighborhood)
        .map(&:unusualactions)
        .reject(&:nil?)
        .each do |sentence|

        sentence.split(' ').each do |word|
          words[neighborhood].push word
        end
      end
    end

    words
  end

  def number_of_crimes_by_dow
    dow = {
      'sunday' => 0,
      'monday' => 0,
      'tuesday' => 0,
      'wednesday' => 0,
      'thursday' => 0,
      'friday' => 0,
      'saturday' => 0,
      'other' => 0
    }

    Crime.all.each do |crime|
      if !crime.day_week.nil? and dow[crime.day_week.downcase]
        dow[crime.day_week.downcase] = dow[crime.day_week.downcase] + 1
      else
        dow['other'] = dow['other'] + 1
      end
    end

    dow
  end

  def number_of_crimes_by_column column_name, number_of_results
    crimes_per_column_type = {}

    Crime.select("DISTINCT \"#{column_name}\"")
      .map(&:"#{column_name}")
      .reject(&:nil?)
      .each do |unique_column_type|

      crime_count = Crime.where("#{column_name} = ?", unique_column_type).count
      crimes_per_column_type[unique_column_type] = crime_count
    end

    crimes_per_column_type.sort_by { |v, k| k }.reverse!.first(number_of_results)
  end
end
