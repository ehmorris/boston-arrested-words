class CrimesController < ApplicationController
  def show
    @dow = number_of_crimes_by_dow

    @neighborhoods = number_of_crimes_by_neighborhood
    @neighborhoods = @neighborhoods
      .sort_by { |neighborhood, crime_count| crime_count }
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
      neighborhoods[neighborhood] = crime_count
    end

    neighborhoods
  end
end
