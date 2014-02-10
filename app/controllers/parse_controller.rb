class ParseController < ApplicationController
  require 'csv'
  
  def show
    @csv_text = File.read('public/boston-crime-with-unusual-actions.csv')

    csv = CSV.parse(@csv_text, :headers => true)
    csv.first do |row|

    end
  end
end
