class CrimesController < ApplicationController
  def show
    @dow = number_of_crimes_by_dow

    @neighborhoods = number_of_crimes_by_neighborhood
    @neighborhoods = @neighborhoods
      .sort_by { |neighborhood, crime_count| crime_count }
      .reverse!

    @crimes_by_weather = number_of_crimes_by_weather
    @crimes_by_weather = @crimes_by_weather
      .sort_by { |weather, crime_count| crime_count }
      .reverse!

    @crimes_by_lighting = number_of_crimes_by_lighting
    @crimes_by_lighting = @crimes_by_lighting
      .sort_by { |lighting, crime_count| crime_count }
      .reverse!
  end

  private

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

  def number_of_crimes_by_neighborhood
    neighborhoods = {}

    Crime.select('DISTINCT "neighborhood"')
      .map(&:neighborhood)
      .reject(&:nil?)
      .each do |neighborhood|
      crime_count = Crime.where("neighborhood = ?", neighborhood).count
      if crime_count > 150
        neighborhoods[neighborhood] = crime_count
      end
    end

    neighborhoods
  end

  def number_of_crimes_by_weather
    crimes = {}

    Crime.select('DISTINCT "weather"')
      .map(&:weather)
      .reject(&:nil?)
      .each do |weather|
      crime_count = Crime.where("weather = ?", weather).count
      if crime_count > 150
        crimes[weather] = crime_count
      end
    end

    crimes
  end

  def number_of_crimes_by_lighting
    crimes = {}

    Crime.select('DISTINCT "lighting"')
      .map(&:lighting)
      .reject(&:nil?)
      .each do |lighting|
      crime_count = Crime.where("lighting = ?", lighting).count
      if crime_count > 150
        crimes[lighting] = crime_count
      end
    end

    crimes
  end
end
