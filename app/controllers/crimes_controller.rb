class CrimesController < ApplicationController
  def show
    @dow = {
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
      if !crime.DAY_WEEK.nil? and @dow[crime.DAY_WEEK.downcase]
        @dow[crime.DAY_WEEK.downcase] = @dow[crime.DAY_WEEK.downcase] + 1
      else
        @dow['other'] = @dow['other'] + 1
      end
    end

    @neighborhoods = Crime.select('DISTINCT "NEIGHBORHOOD"')
      .map(&:NEIGHBORHOOD)
      .reject(&:nil?)

    @crime = Crime.all
  end
end
