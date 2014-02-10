class CrimesController < ApplicationController
  def show
    @crime = Crime.all

    @sunday = 0
    @monday = 0
    @tuesday = 0
    @wednesday = 0
    @thursday = 0
    @friday = 0
    @saturday = 0
    @other = 0;

    @crime.each do |crime|
      if crime.DAY_WEEK == 'Sunday'
        @sunday = @sunday + 1
      elsif crime.DAY_WEEK == 'Monday'
        @monday = @monday + 1
      elsif crime.DAY_WEEK == 'Tuesday'
        @tuesday = @tuesday + 1
      elsif crime.DAY_WEEK == 'Wednesday'
        @wednesday = @wednesday + 1
      elsif crime.DAY_WEEK == 'Thursday'
        @thursday = @thursday + 1
      elsif crime.DAY_WEEK = 'Friday'
        @friday = @friday + 1
      elsif crime.DAY_WEEK == 'Saturday'
        @saturday = @saturday + 1
      else
        @other = @other + 1
      end
    end

    @neighborhoods = Crime.select('DISTINCT "NEIGHBORHOOD"').map(&:NEIGHBORHOOD).reject(&:nil?)
  end
end
